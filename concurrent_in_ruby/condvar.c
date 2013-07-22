/*
 * cp1.c
*/

#include <stdio.h>
#include <pthread.h>

int data_ready = 0;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t  condvar = PTHREAD_COND_INITIALIZER;

void *
consumer (void *notused)
{
    printf ("In consumer thread...\n");
    while (1) {
        pthread_mutex_lock (&mutex);
        // if the date_ready is 0 (date is not ready)
        while (!data_ready) {
            // will wait for condvar to change state (producer does something)
            pthread_cond_wait (&condvar, &mutex);
        }
        // process data
        printf ("consumer:  got data from producer\n");
        data_ready = 0;
        // what signaling at the end
        pthread_cond_signal (&condvar);
        pthread_mutex_unlock (&mutex);
    }
}

void *
producer (void *notused)
{
    printf ("In producer thread...\n");
    while (1) {
        // get data from hardware
        // we'll simulate this with a sleep (1)
        sleep (1);
        printf ("producer:  got data from h/w\n");
        pthread_mutex_lock (&mutex);
        // if the data_ready is 1 (data is not processed)
        while (data_ready) {
            // will wait for condvar to change state (consumer does something)
            pthread_cond_wait (&condvar, &mutex);
        }
        data_ready = 1;
        pthread_cond_signal (&condvar);
        pthread_mutex_unlock (&mutex);
    }
}

int main ()
{
    printf ("Starting consumer/producer example...\n");

    // create the producer and consumer threads
    pthread_create (NULL, NULL, producer, NULL);
    pthread_create (NULL, NULL, consumer, NULL);

    // let the threads run for a bit
    sleep (20);
}
