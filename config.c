#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "config.h"

Config config;


void read_config(const char* filename) {
    FILE* file = fopen(filename, "r");
    if (!file) {
        perror("config.txt not found");
        exit(1);
    }

    char line[256];
    while (fgets(line, sizeof(line), file)) {
        if (strstr(line, "number_of_gangs")) sscanf(line, "number_of_gangs=%d", &config.number_of_gangs);
        if (strstr(line, "min_members_per_gang")) sscanf(line, "min_members_per_gang=%d", &config.min_members);
        if (strstr(line, "max_members_per_gang")) sscanf(line, "max_members_per_gang=%d", &config.max_members);
        if (strstr(line, "rank_levels")) sscanf(line, "rank_levels=%d", &config.rank_levels);
        if (strstr(line, "secret_agent_probability")) sscanf(line, "secret_agent_probability=%d", &config.secret_agent_probability);
        // القيم الجديدة
        if (strstr(line, "max_line")) sscanf(line, "max_line=%d", &config.max_line);
        if (strstr(line, "max_gangs")) sscanf(line, "max_gangs=%d", &config.max_gangs);
        if (strstr(line, "max_members")) sscanf(line, "max_members=%d", &config.max_members);
        if (strstr(line, "promotion_interval")) sscanf(line, "promotion_interval=%d", &config.promotion_interval);
        if (strstr(line, "false_info_probability")) sscanf(line, "false_info_probability=%d", &config.false_info_probability);
        if (strstr(line, "minimum_succeeded"))
            sscanf(line, "minimum_succeeded=%f", &config.minimum_succeeded);
        if (strstr(line, "suspicion_threshold")) {
            sscanf(line, "suspicion_threshold=%d", &config.suspicion_threshold);
        }
        if (strstr(line, "max_reports")) sscanf(line, "max_reports=%d", &config.max_reports);
        if (strstr(line, "max_successful_plans")) sscanf(line, "max_successful_plans=%d", &config.max_successful_plans);
        if (strstr(line, "max_failed_plans")) sscanf(line, "max_failed_plans=%d", &config.max_failed_plans);
        if (strstr(line, "max_captured_agents")) sscanf(line, "max_captured_agents=%d", &config.max_captured_agents);
        if (strstr(line, "death_probability")) sscanf(line, "death_probability=%d", &config.death_probability);



    }

    fclose(file);
}