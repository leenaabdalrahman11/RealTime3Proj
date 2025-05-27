#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <time.h>
#include "gang.h"
#include <sys/wait.h>
#include "config.h"         // يحتوي على read_config و config
#include "shared_memory.h"  // يحتوي على SharedData
#include "ipc.h"            // الرسائل
#include "gang.h"           // يحتوي على create_gang
#include "ipc.h" // تأكد أنك ضايفها
int msgid;  // التعريف الرئيسي للمُتغير
int* gang_in_prison;  // 👈 هذا هو التعريف الرسمي
extern void start_police_monitoring(SharedData* shared_data, int semid);
int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s config.txt\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    int shmid = create_shared_memory();
    int semid = create_semaphore();
    SharedData* shared_data = (SharedData*) attach_shared_memory(shmid);
    msgid = create_message_queue();

    read_config(argv[1]);

    // تهيئة الذاكرة المشتركة
    shared_data->successful_plans = 0;
    shared_data->failed_plans = 0;
    shared_data->captured_agents = 0;

    printf("📄 Loaded config: %d gangs, members range [%d - %d], ranks: %d\n",
           config.number_of_gangs, config.min_members, config.max_members, config.rank_levels);
    gang_in_prison = calloc(config.max_gangs, sizeof(int));

    // إطلاق عمليات العصابات
    for (int i = 0; i < config.number_of_gangs; i++) {
        pid_t pid = fork();
        if (pid == 0) {
            create_gang(i, semid, shared_data);
            exit(EXIT_SUCCESS);
        }
    }

    // انتظار جميع العصابات
    for (int i = 0; i < config.number_of_gangs; i++) {
        wait(NULL);
    }

    int total_knowledge = 0;


    int count = 0;

    int* gang_alerts = calloc(config.max_gangs, sizeof(int));
    int* gang_in_prison = calloc(config.max_gangs, sizeof(int));
    AgentReport* all_reports = malloc(sizeof(AgentReport) * config.max_reports);
    int total_reports = 0;


    // int total_reports = 0;
    AgentReport r;
    printf("🚓 Police is collecting reports:\n");

    while (receive_agent_report(msgid, &r) != -1) {
        if (total_reports >= config.max_reports) break;

        all_reports[total_reports++] = r;

        printf("📝 Report from Agent %d (Gang %d): Suspicion=%d, Knowledge=%d, Alert=%s\n",
               r.member_id + 1, r.gang_id + 1, r.suspicion_level, r.knowledge_level,
               r.is_alert ? "YES" : "NO");

        if (r.is_alert) {
            gang_alerts[r.gang_id]++;
        }
    }
    for (int i = 0; i < config.number_of_gangs; i++) {
        if (gang_alerts[i] >= config.police_action_threshold) {
            printf("🚔 Police takes action against Gang %d! (%d alerts)\n", i + 1, gang_alerts[i]);

            gang_in_prison[i] = config.prison_duration;
            printf("⛓️ Gang %d is now in prison for %d seconds.\n", i + 1, config.prison_duration);
        } else {
            printf("🟡 Gang %d under monitoring: %d alerts (below threshold).\n", i + 1, gang_alerts[i]);
        }
    }
    destroy_message_queue(msgid);
    int terminate_due_to = 0;
    if (shared_data->failed_plans >= config.max_failed_plans) {
        terminate_due_to = 1;
        printf("❌ Simulation ends: Too many failed plans (%d >= %d)\n",
               shared_data->failed_plans, config.max_failed_plans);
    } else if (shared_data->successful_plans >= config.max_successful_plans) {
        terminate_due_to = 2;
        printf("✅ Simulation ends: Gangs succeeded too much (%d >= %d)\n",
               shared_data->successful_plans, config.max_successful_plans);
    } else if (shared_data->captured_agents >= config.max_captured_agents) {
        terminate_due_to = 3;
        printf("💀 Simulation ends: Too many agents exposed (%d >= %d)\n",
               shared_data->captured_agents, config.max_captured_agents);
    }


    if (terminate_due_to > 0) {
        printf("🎯 Simulation terminated due to condition #%d.\n", terminate_due_to);
    }

    printf("🚔 Total reports received: %d\n", count);
    printf("📊 Simulation Summary:\n");
    printf("✅ Successful Plans: %d\n", shared_data->successful_plans);
    printf("❌ Failed Plans: %d\n", shared_data->failed_plans);
    printf("🕵️‍♂️ Captured Agents: %d\n", shared_data->captured_agents);

    detach_shared_memory(shared_data);
    destroy_shared_memory(shmid);
    destroy_semaphore(semid);
    free(gang_alerts);
    free(gang_in_prison);
    // free(gang_in_prison);

    free(all_reports);

    printf("🎯 All gangs have been initialized.\n");
    return EXIT_SUCCESS;
}


