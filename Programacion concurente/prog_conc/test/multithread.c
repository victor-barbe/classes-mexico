#include <stdio.h>
#include <pthread.h>

// shared variable between threads
int counter = 0;

static void *thread_t(void *arg)
{
    // local counter taking value from shared counter
    int cnt = counter;
    // prints the argument followed by the local variable
    printf("%s: %i\n", (char *)arg, cnt);
    // add 1 to the shared variable
    counter = cnt + 1;
    // prints the argument followed by the shared variable
    printf("%s: %i\n", (char *)arg, counter);
    return NULL;
}

static void *thread_u(void *arg)
{
    // local counter taking value from shared counter
    int cnt = counter;
    // prints the argument followed by the local variable
    printf("%s: %i\n", (char *)arg, cnt);
    // add 1 to the shared variable
    counter = cnt + 1;
    // prints the argument followed by the shared variable
    printf("%s: %i\n", (char *)arg, counter);
    return NULL;
}

int main()
{
    pthread_t t1, t2;

    // starts a new thread "t1" in the calling process. *thread_t is called, receiving "T" in parameters.
    pthread_create(&t1, NULL, *thread_t, "T");
    // starts a new thread "t1" in the calling process. *thread_u is called, receiving "U" in parameters.
    pthread_create(&t2, NULL, *thread_u, "U");

    // calls t1 and t2
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    printf("counter: %i\n", counter); // counter return 1, but has been incremented 2 times, why ?
    // The two threads ran concurrently. It's like they both started "at the same time" (not exactly), and modified the value of the counter.
    // From both of them, the initial value of counter was 0, that's why it prints 1. Counter will never get the value 2 in this configuration.
    // If you launch the program several times, you will see that the order of execution isn't defined. Sometimes, thread_t looks to start first, sometimes it's thread_u
    // You can't determine which thread will starts first, that's one of their properties.
    return 0;
}