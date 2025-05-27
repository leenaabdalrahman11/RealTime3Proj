// gang.h
#define MAX_MEMBERS 10
#include "shared_memory.h"

#ifndef GANG_H
#define GANG_H
extern int msgid;
extern int* gang_in_prison;

typedef struct {
    int id;
    int rank;
    int is_secret_agent;
    int gang_id;
    int executed;
    // ⬇️ جديد:
    int missions_participated;
    int missions_succeeded;
    int preparation_level;  // ✅ أضفه هنا
    time_t joined_at;

    // جديد 👇
    int received_info_is_true;
    char known_target[100]; // ما يعرفه العضو عن الهدف
} Member;

typedef struct {
    int id;
    int num_members;
    Member members[MAX_MEMBERS];
} Gang;
typedef struct {
    Member member;
    int required_preparation;
    Member* all_members;
    int member_count;
} ThreadArg;

// Function prototypes
void investigate_members(ThreadArg* args, int count, int semid, SharedData* shared_data, int* pending_replacements);

Member create_new_member(int id, int gang_id, int rank);

void* member_thread(void* arg);
void create_gang(int gang_id, int semid, SharedData* shared_data);

#endif