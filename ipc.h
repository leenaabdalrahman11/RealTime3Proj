// ipc.h

#ifndef IPC_H
#define IPC_H

#include <sys/ipc.h>
#include <sys/msg.h>

#define MSG_KEY 0x9999
extern int msgid;
extern int* gang_in_prison;

typedef struct {
    long mtype;       // نوع الرسالة (مثلاً 1 = تقرير)
    int gang_id;
    int member_id;
    int suspicion_level;
    int knowledge_level;
    int is_alert;  // 1 إذا أرسل تنبيه، 0 إذا مجرد تقرير

} AgentReport;

int create_message_queue();
void send_agent_report(int msgid, AgentReport* report);
int receive_agent_report(int msgid, AgentReport* report);
void destroy_message_queue(int msgid);

#endif
