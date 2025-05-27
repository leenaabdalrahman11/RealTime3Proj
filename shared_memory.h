// shared_memory.h

#ifndef SHARED_MEMORY_H
#define SHARED_MEMORY_H

#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>

typedef struct {
    int successful_plans;
    int failed_plans;
    int captured_agents;
    volatile int stop_simulation_flag;  // علم إشارة لإنهاء المحاكاة


} SharedData;

#define SHM_KEY 0x1364
#define SEM_KEY 0x5618

int create_shared_memory();
void* attach_shared_memory(int shmid);
void detach_shared_memory(void* shm_ptr);
void destroy_shared_memory(int shmid);

int create_semaphore();
void semaphore_wait(int semid);
void semaphore_signal(int semid);
void destroy_semaphore(int semid);

#endif
