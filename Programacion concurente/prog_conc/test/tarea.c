#include <stdio.h>
#include <pthread.h>

// initialize global variables
int counter = 0;
pthread_mutex_t lock;

static void *thread_t(void *arg)
{
    // locks our lock variable, forcing the thread to process
    pthread_mutex_lock(&lock);
    // creates a local counter variable, equals to our global counter (global counter shared between processes)
    int cnt;
    cnt = counter;
    // prints the argument of the thread followed by the local counter
    printf("%s: %i\n", (char *)arg,
           cnt);
    // add to the shared counter +1
    counter = cnt + 1;
    // prints the argument of the thread followed by the shared counter
    printf("%s: %i\n", (char *)arg,
           counter);
    // unlocks the "lock" variable in order to allow other threads dependent of this lock to process
    pthread_mutex_unlock(&lock);
    return NULL;
}

static void *thread_u(void *arg)
{
    // locks our lock variable, forcing the thread to process
    pthread_mutex_lock(&lock);
    // creates a local counter variable, equals to our global counter (global counter shared between processes)
    int cnt;
    cnt = counter;
    // prints the argument of the thread followed by the local counter
    printf("%s: %i\n", (char *)arg,
           cnt);
    // add to the shared counter +1
    counter = cnt + 1;
    // prints the argument of the thread followed by the shared counter
    printf("%s: %i\n", (char *)arg,
           counter);
    // unlocks the "lock" variable in order to allow other threads dependent of this lock to process
    pthread_mutex_unlock(&lock);
    return NULL;
}

int main()
{
    // initialize our threads
    pthread_t t1, t2;
    // check if our lock has been correctly initialized. If not, return an error. (The program couldn't proceed if our lock is not correctly initialized)
    if (pthread_mutex_init(&lock, NULL) != 0)
    {
        printf("\nmutex init has failed \n");
        return 1;
    }

    // starts a new thread "t1" in the calling process. *thread_t is called, receiving "T" in parameters.
    pthread_create(&t1, NULL, *thread_t,
                   "T");

    // starts a new thread "t2" in the calling process. *thread_u is called, receiving "U" in parameters.
    pthread_create(&t1, NULL, *thread_u,
                   "U");

    // waits for t1 to end, return 0 if succesful
    pthread_join(t1, NULL);

    // waits for t2 to end, return 0 if succesful
    pthread_join(t2, NULL);

    // prints the counter incremented in the differents threads.
    printf("counter: %i\n", counter);

    // free storage
    pthread_mutex_destroy(&lock);
    return 0;
}