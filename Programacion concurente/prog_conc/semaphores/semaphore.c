#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

// global variables
int counter = 0;
sem_t sem;

static void *thread_t(void *arg)
{
    sem_wait(&sem); // if sem > 0, decrements sem, else doesn't allow the execution of the next steps of the code

    int cnt = counter;                    // local counter taking value of glocal counter
    printf("%s: %i\n", (char *)arg, cnt); // prints argument followed by local counter

    counter = cnt + 1;                        // add 1 to global counter
    printf("%s: %i\n", (char *)arg, counter); // prints argument followed by global counter
    sem_post(&sem);                           // increments the semaphore by 1, allowing another thread to be woken up
    return NULL;
}

// thread_t and thread_u have the exact same comments

static void *thread_u(void *arg)
{
    sem_wait(&sem);
    int cnt;
    cnt = counter;
    printf("%s: %i\n", (char *)arg, cnt);
    counter = cnt + 1;
    printf("%s: %i\n", (char *)arg, counter);
    sem_post(&sem);
    return NULL;
}

int main()
{

    pthread_t t1, t2; // initialize 2 threads

    sem_init(&sem, 0, 1); // initialize our sem at value 1, parameters 0 means that this semaphore is shared between threads

    // starts a new thread "t1" in the calling process. *thread_t is called, receiving "T" in parameters.
    pthread_create(&t1, NULL, *thread_t,
                   "T");
    // starts a new thread "t1" in the calling process. *thread_u is called, receiving "U" in parameters.
    pthread_create(&t1, NULL, *thread_u,
                   "U");
    // calls t1 and t2
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    // prints the global counter
    printf("counter: %i\n", counter);
    return 0;
}

// Note : sem_init looks deprecated on our current OS version. The previous code should output 2 as final counter while here it prints 1 for us.
// It comes from iOS that doesn't use POSIX semaphores but GCD semaphores