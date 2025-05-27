// shared_memory.c

#include "shared_memory.h"
#include <stdio.h>
#include <stdlib.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <unistd.h>

int create_shared_memory() {
    int shmid = shmget(SHM_KEY, sizeof(SharedData), IPC_CREAT | 0666);
    if (shmid < 0) {
        perror("shmget failed");
        exit(1);
    }
    return shmid;
}

void* attach_shared_memory(int shmid) {
    void* ptr = shmat(shmid, NULL, 0);
    if (ptr == (void*)-1) {
        perror("shmat failed");
        exit(1);
    }
    return ptr;
}

void detach_shared_memory(void* shm_ptr) {
    shmdt(shm_ptr);
}

void destroy_shared_memory(int shmid) {
    shmctl(shmid, IPC_RMID, NULL);
}

int create_semaphore() {
    int semid = semget(SEM_KEY, 1, IPC_CREAT | 0666);
    if (semid < 0) {
        perror("semget failed");
        exit(1);
    }
    semctl(semid, 0, SETVAL, 1); // initialize to 1
    return semid;
}

void semaphore_wait(int semid) {
    struct sembuf op = {0, -1, 0};
    semop(semid, &op, 1);
}

void semaphore_signal(int semid) {
    struct sembuf op = {0, 1, 0};
    semop(semid, &op, 1);
}

void destroy_semaphore(int semid) {
    semctl(semid, 0, IPC_RMID);
}
