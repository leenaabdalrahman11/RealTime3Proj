#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <time.h>
#include <string.h>
#include <stddef.h>  // لـ NULL
#include "gang.h"
#include "config.h"
#include "shared_memory.h"
#include "police.h"

#include <sys/msg.h>
#include "ipc.h"

const char* TARGETS[] = {
        "Robbing banks and financial institutions",
        "Robbing gold/jewelry shops",
        "Drug trafficking (buying and selling)",
        "Robbing expensive art work",
        "Kidnapping wealthy people and asking for ransoms",
        "Blackmailing wealthy people",
        "Arm trafficking"
};

#define NUM_TARGETS (sizeof(TARGETS) / sizeof(TARGETS[0]))
void investigate_members(ThreadArg* args, int count, int semid, SharedData* shared_data, int* pending_replacements){
for (int i = count - 1; i >= 0; i--) {
    Member* m = &args[i].member;

    if (m->is_secret_agent) {
       int chance = rand() % 100;
if (chance < 50) {
printf("🚨 Gang discovered Agent %d in Gang %d (Rank: %d)! Eliminating...\n",
m->id + 1, m->gang_id + 1, m->rank);

semaphore_wait(semid);
shared_data->captured_agents++;
semaphore_signal(semid);

m->executed = 1;
(*pending_replacements)++;
printf("💀 Agent %d in Gang %d has been EXECUTED immediately!\n",
(int)m->id, (int)m->gang_id);
printf("🛠️ DEBUG >> m pointer: %p | id: %d | gang: %d | executed: %d\n",
(void*)m, m->id + 1, m->gang_id + 1, m->executed);


printf("🔄 Replacing Agent %d in Gang %d...\n", m->id + 1, m->gang_id + 1);
}
}
}
}
void wait_for_prison_release(int msgid, int gang_id) {
    PoliceMessage pm;
    ssize_t ret = msgrcv(msgid, &pm, sizeof(PoliceMessage) - sizeof(long), gang_id + 10, IPC_NOWAIT);
    if (ret != -1) {
        printf("⛓️ Gang %d arrested for %d seconds!\n", gang_id + 1, pm.prison_time);
        sleep(pm.prison_time);
        printf("🔓 Gang %d released and resuming operations.\n", gang_id + 1);
    }
}
void* member_thread(void* arg) {
    ThreadArg* t = (ThreadArg*)arg;
    Member* m = &t->member;
    int required_preparation = t->required_preparation;
// قبل أي تنفيذ أو أثناء المهمة
    int sudden_death = rand() % 100;
    if (sudden_death < config.death_probability) {
        printf("💀 Member %d in Gang %d DIED suddenly!\n", m->id + 1, m->gang_id + 1);
        m->executed = 1;  // علامة على أنه مات
        pthread_exit(NULL);  // يخرج فورًا من الحياة
    }

    printf("🔍 Member %d geng id %d :  Starting...\n", m->id + 1, m->gang_id + 1);
    printf("👤 Member %d | Rank: %d | Secret Agent: %s | geng id : %d\n",
           m->id + 1, m->rank, m->is_secret_agent ? "YES" : "NO", m->gang_id + 1);
    m->preparation_level = rand() % 11;


    printf("🔧 Member %d in Gang %d preparation: %d/%d\n",
           m->id + 1, m->gang_id + 1, m->preparation_level, required_preparation);


    if (m->is_secret_agent) {
        sleep(1);

        int interactions = 0;
        int gathered_knowledge = 0;

        ThreadArg* t = (ThreadArg*)arg;
        Member* m = &t->member;
        int required_preparation = t->required_preparation;

        printf("🔍 Member %d | Gang %d | Rank %d | Secret Agent: %s\n",
               m->id + 1, m->gang_id + 1, m->rank, m->is_secret_agent ? "YES" : "NO");

        // العميل السري يتفاعل فقط مع أعضاء نفس الرتبة أو أقل
        for (int j = 0; j < t->member_count; j++) {
            Member* other = &t->all_members[j];

            if (other->id == m->id) continue;  // لا يتفاعل مع نفسه
            if (!other->is_secret_agent && other->rank <= m->rank) {
                int info_quality = rand() % 10;  // معلومات عشوائية
                gathered_knowledge += info_quality;
                interactions++;
            }
        }

        int knowledge = (interactions > 0) ? (gathered_knowledge / interactions) : rand() % 3;
        int suspicion = 5 + rand() % 5;  // الشك يبقى ثابت أو يمكن ربطه بعدد التفاعلات

        printf("🤐 Suspicion: %d | Knowledge: %d (Agent %d in Gang %d)\n",
               suspicion, knowledge, m->id +1, m->gang_id + 1);


        if (suspicion >= config.suspicion_threshold) {  // ✅ الشرط المضاف
            AgentReport report;
            report.mtype = 1;
            report.gang_id = m->gang_id;
            report.member_id = m->id;
            report.suspicion_level = suspicion;
            report.knowledge_level = knowledge;

            send_agent_report(msgid, &report);

            printf("📨 Agent %d in Gang %d sent report: Suspicion=%d, Knowledge=%d\n",
                   m->id + 1, m->gang_id + 1, suspicion, knowledge);
        } else {
            printf("❗ Agent %d in Gang %d chose not to report (Suspicion: %d < Threshold: %d)\n",
                   m->id + 1, m->gang_id + 1, suspicion, config.suspicion_threshold);
        }

        printf("🕵️ Agent %d THINKS target is: %s [%s]\n",
               m->id + 1, m->known_target,
               m->received_info_is_true ? "TRUSTED" : "DUBIOUS");
    }
    pthread_exit(NULL);
}
void maybe_promote(Member* m, int semid) {
    time_t now = time(NULL);
    int time_served = now - m->joined_at;
    if (m->is_secret_agent) {
        sleep(1);
        int suspicion = rand() % 10;
        int knowledge = rand() % 10;

        printf("🤐 Suspicion: %d | Knowledge: %d (Agent %d in Gang %d)\n",
               suspicion, knowledge, m->id + 1, m->gang_id + 1);

        AgentReport report;
        report.mtype = 1;
        report.gang_id = m->gang_id;
        report.member_id = m->id;
        report.suspicion_level = suspicion;
        report.knowledge_level = knowledge;

        if (suspicion >= config.suspicion_threshold) {
            report.is_alert = 1;
            printf("📣 Agent %d raised an ALERT for Gang %d!\n", m->id + 1, m->gang_id + 1);
        } else {
            report.is_alert = 0;
            printf("📘 Agent %d submitted a normal report.\n", m->id + 1);
        }
        int threshold = config.agent_report_threshold;  // مثلا قيمة العتبة من ملف الإعدادات
        send_agent_report(msgid, &report);

        printf("📨 Agent %d in Gang %d sent report: Suspicion=%d, Knowledge=%d, Alert=%s\n",
               m->id + 1, m->gang_id + 1, suspicion, knowledge, report.is_alert ? "YES" : "NO");
    }
}

Member create_new_member(int id, int gang_id, int rank) {
    Member m;
    m.id = id;
    m.gang_id = gang_id;
    m.rank = rank;
    m.is_secret_agent = (rand() % 100 < config.secret_agent_probability) ? 1 : 0;
    m.executed = 0;
    m.missions_succeeded = 0;
    m.missions_participated = 0;
    m.joined_at = time(NULL);
    m.received_info_is_true = 1;
    strcpy(m.known_target, "Unknown");
    return m;
}


void create_gang(int gang_id, int semid, SharedData* shared_data) {
    printf("SSSSSSSSSSSSSSSSSSSSSSSSSSS\n");
    int successful_local = 0;
    int failed_local = 0;
    int pending_replacements = 0;

/*
    if (gang_in_prison[gang_id] > 0) {
        printf("⛓️ Gang %d is in prison, waiting %d seconds...\n", gang_id + 1, gang_in_prison[gang_id]);
        sleep(gang_in_prison[gang_id]);
        gang_in_prison[gang_id] = 0;

        printf("🔁 Gang %d released! Starting a new target cycle.\n", gang_id + 1);
    }*/
    while (1) {
        wait_for_prison_release(msgid, gang_id);

        pending_replacements = 0;
        srand(time(NULL) + getpid());
        int member_count = config.min_members + rand() % (config.max_members - config.min_members + 1);
        printf("🚩 Gang %d: Creating %d members\n", gang_id + 1, member_count);

        pthread_t threads[member_count + pending_replacements];
        ThreadArg args[member_count + pending_replacements];
        // 🔁 استبدال الأعضاء المعدومين قبل بداية الجولة الجديدة
        for (int i = 0; i < pending_replacements; i++) {
            int new_id = i;  // نحافظ على نفس الأرقام أو يمكن تعديلها إن لزم
            printf("🆕 Replacing executed member %d in Gang %d with a new one.\n", new_id + 1, gang_id + 1);

            Member new_member = create_new_member(new_id, gang_id, config.rank_levels - 1 - (new_id * config.rank_levels / config.max_members));
            new_member.joined_at = time(NULL);

            // نحفظه مؤقتًا في مكان في args
            args[new_id].member = new_member;
            args[new_id].required_preparation = 0;
            args[new_id].all_members = &args[0].member;  // سيتم تحديثه لاحقًا
        }
        const char* selected_target = NULL;
        int preparation_time = 3 + rand() % 4;
        int required_preparation = 3 + rand() % 5;

        // 1️⃣ إنشاء الأعضاء الأساسيين
        for (int i = 0; i < member_count; i++) {
            args[i].member.id = i;
            args[i].member.gang_id = gang_id;
            args[i].member.is_secret_agent = (rand() % 100 < config.secret_agent_probability) ? 1 : 0;
            args[i].member.joined_at = time(NULL);
            args[i].all_members = &args[0].member;
            args[i].member_count = member_count;
            args[i].required_preparation = required_preparation;

            int rank_range = config.rank_levels;
            args[i].member.rank = rank_range - 1 - (i * rank_range / member_count);
            if (args[i].member.rank < 0) args[i].member.rank = 0;
        }
       // printf("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
        // 2️⃣ إضافة الأعضاء البدلاء
        for (int i = 0; i < pending_replacements; i++) {
            int new_id = member_count + i;
            int replacement_rank = config.rank_levels - 1 - (new_id * config.rank_levels / (member_count + pending_replacements));
            if (replacement_rank < 0) replacement_rank = 0;
            args[new_id].member = create_new_member(new_id, gang_id, replacement_rank);
            args[new_id].required_preparation = required_preparation;
            args[new_id].all_members = &args[0].member;
            args[new_id].member_count = member_count + pending_replacements;
        }

        member_count += pending_replacements;
        pending_replacements = 0;
        // 3️⃣ اختيار الهدف والقائد
        int leader_is_agent = 0;
        for (int i = 0; i < member_count; i++) {
            if (args[i].member.rank == config.rank_levels - 1) {
                selected_target = TARGETS[rand() % NUM_TARGETS];
                printf("🎯 Gang %d Leader (Member %d) selected target: %s\n",
                       gang_id + 1, args[i].member.id + 1, selected_target);
                if (args[i].member.is_secret_agent) {
                    leader_is_agent = 1;
                    printf("😈 WARNING: Gang %d Leader is a secret AGENT!\n", gang_id + 1);
                }
                break;
            }
        }

        if (selected_target == NULL) {
            selected_target = TARGETS[rand() % NUM_TARGETS];
        }

        printf("⏳ Gang %d preparing for: '%s' | Required prep: %d | Time: %d sec\n",
               gang_id + 1, selected_target, required_preparation, preparation_time);

        // 4️⃣ توزيع المعلومات على الأعضاء
        for (int i = 0; i < member_count; i++) {
            Member* m = &args[i].member;
            if (m->rank == config.rank_levels - 1) {
                strcpy(m->known_target, selected_target);
                m->received_info_is_true = 1;
                continue;
            }

            int lie_probability = leader_is_agent ? 60 : 30;
            int lie = rand() % 100 < lie_probability;

            if (lie) {
                const char* fake_target;
                do {
                    fake_target = TARGETS[rand() % NUM_TARGETS];
                } while (strcmp(fake_target, selected_target) == 0);
                strcpy(m->known_target, fake_target);
                m->received_info_is_true = 0;
            } else {
                strcpy(m->known_target, selected_target);
                m->received_info_is_true = 1;
            }

            printf("🧠 Member %d (Rank %d) knows: %s [%s]\n",
                   m->id + 1, m->rank, m->known_target,
                   m->received_info_is_true ? "REAL" : "FAKE");
        }

        // 5️⃣ تصفير التحضير
        for (int i = 0; i < member_count; i++) {
            args[i].member.preparation_level = 0;
        }

        // 6️⃣ إطلاق الخيوط
        for (int i = 0; i < member_count; i++) {
            ThreadArg* t = malloc(sizeof(ThreadArg));
            t->member = args[i].member;
            t->required_preparation = args[i].required_preparation;

           // pthread_create(&threads[i], NULL, member_thread, t);
            pthread_create(&threads[i], NULL, member_thread, &args[i]);



        }
        for (int i = 0; i < member_count; i++) {
            pthread_join(threads[i], NULL);
        }

// 🔁 استبدال الأعضاء الذين تم إعدامهم بعض المهمة
        for (int i = 0; i < member_count; i++) {
            if (args[i].member.executed) {
                printf("♻️ Reinitializing Member %d in Gang %d...\n", args[i].member.id + 1, args[i].member.gang_id + 1);
                args[i].member = create_new_member(args[i].member.id, gang_id, args[i].member.rank);
            }
        }
        // 7️⃣ تقييم الجاهزية
        int ready_members = 0;
        for (int i = 0; i < member_count; i++) {
            Member* m = &args[i].member;
            m->missions_participated++;
            int member_prep = m->received_info_is_true ? rand() % 16 : rand() % 8;
            if (member_prep >= required_preparation) {
                ready_members++;
                m->missions_succeeded++;
                printf("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii\n");
            }
            maybe_promote(m, semid);
        }

        float readiness_ratio = (float)ready_members / member_count;
        int plan_success = (readiness_ratio >= config.minimum_succeeded && rand() % 100 > 20);
        printf("loooooooooooooooooooooooooooo %d \n", plan_success);
        // 8️⃣ التحديث المشترك
        semaphore_wait(semid);
        if (plan_success) {

            printf("✅ Gang %d succeeded in: %s\n", gang_id + 1, selected_target);
            shared_data->successful_plans++;
            successful_local++;
        } else {
            printf("❌ Gang %d failed to execute: %s\n", gang_id + 1, selected_target);
            shared_data->failed_plans++;
            failed_local++;

            printf("🔍 Internal investigation in Gang %d...\n", gang_id + 1);
            for (int i = 0; i < member_count; i++) {
                Member* m = &args[i].member;
                if (m->rank >= config.rank_levels - 2 && m->is_secret_agent && !m->executed) {
                    printf("❗ Agent %d (Rank %d) discovered! Eliminated.\n",
                           m->id + 1, m->rank);
                    m->executed = 1;
                    shared_data->captured_agents++;
                }
            }
        }
        semaphore_signal(semid);

        // 9️⃣ التحقيق واستبدال العملاء
        investigate_members(args, member_count, semid, shared_data, &pending_replacements);

        sleep(2);

        // 🔟 التوقف بعد عدد معين من المحاولات
        if (successful_local >= 3 || failed_local >= 3) {
            printf("🛑 Gang %d finished mission cycle (Success: %d, Fail: %d).\n",
                   gang_id + 1, successful_local, failed_local);
            break;
        }
    }
}