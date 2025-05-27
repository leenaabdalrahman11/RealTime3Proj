// police.c
#include <stdio.h>
#include <stdlib.h>
#include "ipc.h"
#include <time.h>
#include <unistd.h>
#include "unistd.h"
#include "shared_memory.h"
#include "config.h"


extern Config config;  // تعريف config مشترك (إذا تعرف في مكان آخر)

void police_process(int msgid, SharedData* shared_data) {
    int* gang_alerts = calloc(config.max_gangs, sizeof(int));
    int* gang_in_prison = calloc(config.max_gangs, sizeof(int));
    AgentReport* all_reports = malloc(sizeof(AgentReport) * config.max_reports);
    int total_reports = 0;
    printf("🚓 Police is collecting reports:\n");

    AgentReport r;
    int ret = receive_agent_report(msgid, &r);
    printf("receive_agent_report returnedييييييييييييييييييييييي: %d\n", ret);
    if (ret == -1) {
        perror("receive_agent_report failedيييييييييييييييييييييييييييييييي");
    }
    sleep(1);
    while (receive_agent_report(msgid, &r) != -1) {
        printf("\nmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm\n");

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

    free(gang_alerts);
    free(gang_in_prison);
    free(all_reports);
}
