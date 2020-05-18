#ifndef SET_H
#define SET_H

#define BUCKET_COUNT 31

typedef struct Bucket
{
    char* data;
    struct Bucket* next;
} Bucket;


typedef struct Set {
    Bucket** buckets;
} Set;

Bucket* newBucket();
Bucket* newBucketWithData(char* data);
void freeBucket(Bucket* bucket);
int insert(Set* set, char* name);
int hash(char* name);
Set* newSet();
void freeSet(Set* set);

#endif