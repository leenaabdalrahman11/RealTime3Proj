// police.c
#include <stdio.h>
#include <stdlib.h>
#include "ipc.h"
#include <time.h>
#include <unistd.h>
#include "unistd.h"
#include "shared_memory.h"
#include "config.h"
#include "police.h"

extern Config config;
extern int msgid;
extern SharedData* shared_data;

void police_process(int msgid, SharedData* shared_data) {
    int* gang_alerts = calloc(config.max_gangs, sizeof(int));
    int* gang_in_prison = calloc(config.max_gangs, sizeof(int));
    AgentReport* all_reports = malloc(sizeof(AgentReport) * config.max_reports);
    int total_reports = 0;
    printf("🚓 Police is collecting reports:\n");
    printf("🔍 ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]Debug: config.prison_duration = %d\n", config.prison_duration);


    AgentReport r;
    int ret = receive_agent_report(msgid, &r);
    printf("receive_agent_report returnedييييييييييييييييييييييي: %d\n", ret);
    if (ret == -1) {
        perror("receive_agent_report failedيييييييييييييييييييييييييييييييي");
    }
    sleep(1);
    int running = 1;
    while (running) {
        if (total_reports >= config.max_reports) {
            printf("Reached max reports, stopping police process.\n");
            break;
        }
        if (shared_data->stop_simulation_flag) {
            printf("Received stop signal, exiting police process.\n");
            break;
        }

        int ret = receive_agent_report(msgid, &r);
        if (ret == -1) {

            usleep(500000);
            continue;
        }
        if (total_reports >= config.max_reports) break;

        all_reports[total_reports++] = r;

        printf("📝 Report from Agent %d (Gang %d): Suspicion=%d, Knowledge=%d, Alert=%s\n",
               r.member_id + 1, r.gang_id + 1, r.suspicion_level, r.knowledge_level,
               r.is_alert ? "YES" : "NO");

        if (r.is_alert) {
            gang_alerts[r.gang_id]++;
        }
        if (gang_alerts[r.gang_id] >= 2 && gang_in_prison[r.gang_id] == 0) {
            printf("🚔 Police takes action: Arresting Gang %d for %d seconds!\n",
                   r.gang_id + 1, config.prison_duration);
            fflush(stdout);


            gang_in_prison[r.gang_id] = config.prison_duration;

            PoliceMessage pm;
            pm.mtype = r.gang_id + 10; // نوع رسالة خاص للعصابة
            pm.gang_id = r.gang_id;
            pm.prison_time = config.prison_duration;

            if (msgsnd(msgid, &pm, sizeof(PoliceMessage) - sizeof(long), 0) == -1) {
                perror("Failed to send police arrest message");
            }
        }
        for (int i = 0; i < config.number_of_gangs; i++) {
            if (gang_in_prison[i] > 0) {
                gang_in_prison[i]--;
                if (gang_in_prison[i] == 0) {
                    printf("🔓 Gang %d is released from prison and can resume activity.\n", i + 1);
                    gang_alerts[i] = 0;
                }
            }
        }
        if (total_reports >= config.max_reports) {
            printf("Reached max reports, stopping police process.\n");
            running = 0;
        }
        if (shared_data->stop_simulation_flag) {
            running = 0;
        }

        sleep(1);
    }
    free(gang_alerts);
    free(gang_in_prison);
    free(all_reports);
}
