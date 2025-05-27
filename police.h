// police.h
#ifndef POLICE_H
#define POLICE_H

typedef struct {
    long mtype;       // نوع الرسالة (مثلاً gang_id + 10)
    int gang_id;      // رقم العصابة المعتقلة
    int prison_time;  // مدة السجن بالثواني
} PoliceMessage;

#endif // POLICE_H
