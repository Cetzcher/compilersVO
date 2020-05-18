#include "set.h"
#include <stdlib.h>
#include <string.h>

Bucket* newBucket() {
    return newBucketWithData(NULL);
}

Bucket* newBucketWithData(char* data) {
    Bucket* bucket = malloc(sizeof(Bucket));
    bucket->data = data;
    bucket->next = NULL;
    return bucket;
}

void freeBucket(Bucket* bucket) {
    // free this bucket and all references to next
    Bucket* next = bucket->next;
    free(bucket);
    if(next != NULL)
        freeBucket(next);
}

int insert(Set* set, char* name) {
    int hashcode = hash(name);
    int bucketIndex = abs(hashcode) % BUCKET_COUNT;
    Bucket* bucket = set->buckets[bucketIndex];
    // loop through bucket until A) we find data == name or data == NULL
    for(; bucket->next != NULL; bucket = bucket->next) {
        if(bucket->data == NULL) {
            // create new bucket
            Bucket* nbuck = newBucketWithData(name);
            bucket->next = nbuck;
            return 1;   // we have inserted our element
        } else if(strcmp(bucket->data, name) == 0) {
            return 0; // elem is already in the set so we quit.
        }
    }
    return -1;   // something went wrong
}

int hash(char* name) {
    int i = 0;
    int sum = 0;
    while (1) {
        char cur = name[i];
        if(cur == NULL)
            return sum;
        sum = 31 * sum + cur;   // this is javas string hashcode impl.        
    }
}

Set* newSet() {
    Set* set = malloc(sizeof(Set));
    set->buckets = malloc(sizeof(Bucket*) * BUCKET_COUNT);
    for(int i = 0; i < BUCKET_COUNT; i++)
        set->buckets[i] = newBucket();
    return set;
}

void freeSet(Set* set) {
    for(int i = 0; i < BUCKET_COUNT; i++)
        freeBucket(set->buckets[i]);
}