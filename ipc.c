// ipc.c
#include "ipc.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/msg.h>

int create_message_queue() {
    int msgid = msgget(MSG_KEY, IPC_CREAT | 0666);
    if (msgid < 0) {
        perror("msgget failed");
        exit(1);
    }
    return msgid;
}
void send_agent_report(int msgid, AgentReport* report) {
    printf("📩 Sending report from Agent %d (Gang %d): Suspicion=%d, Knowledge=%d\n",
           report->member_id +1, report->gang_id +1, report->suspicion_level, report->knowledge_level);
    if (msgsnd(msgid, report, sizeof(AgentReport) - sizeof(long), 0) == -1) {
        perror("msgsnd failed");
    }
}
int receive_agent_report(int msgid, AgentReport* report) {
    return msgrcv(msgid, report, sizeof(AgentReport) - sizeof(long), 1, IPC_NOWAIT);
}

void destroy_message_queue(int msgid) {
    msgctl(msgid, IPC_RMID, NULL);
}
