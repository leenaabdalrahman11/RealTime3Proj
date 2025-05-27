#ifndef CONFIG_H
#define CONFIG_H
extern int msgid;
extern int* gang_in_prison;

typedef struct {
    int number_of_gangs;
    int min_members;
    int max_members;
    int rank_levels;
    int secret_agent_probability;
    int false_info_probability;
    int knowledge_threshold;
    int suspicion_threshold;
    int agent_report_threshold;
    int police_action_threshold;
    int prison_duration;
    int death_probability;
    int max_failed_plans;
    int max_successful_plans;
    int max_executed_agents;
    int max_captured_agents;
    int max_line;   // ✅ أضف هذه إذا كنت تحتاجها
    int max_gangs;  // ✅ أضف هذه إذا كنت تحتاجها
    int promotion_interval;
 //   int false_info_probability;
    int max_reports;
    float minimum_succeeded; // ✅ جديد


} Config;

extern Config config;
void read_config(const char* filename);

#endif
