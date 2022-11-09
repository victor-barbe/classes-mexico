
#include "cliente.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>

char c1='A';
char c2='B';
char c3='C';
char c4='D';
int i=16;

void send_integer(int sock);

int main(int argc, char *argv[])
{
    int sock = connection();
    int sock1 = connection();
    int sock2 = connection();
    int sock3 = connection();
    // communicating with server
    send_integer(sock);

    close(sock);
    return 0;
}

void send_integer(int sock)
{
    int integer;
    
    // send some data
    if(send(sock, &c1, sizeof(c1), 0) < 0) {
        puts("Send failed");
        exit(1);
    }
    if(send(sock, &c2, sizeof(c2), 0) < 0) {
        puts("Send failed");
        exit(1);
    }
    if(send(sock, &i, sizeof(i), 0) < 0) {
        puts("Send failed");
        exit(1);
    }
    if(send(sock, &c3, sizeof(c3), 0) < 0) {
        puts("Send failed");
        exit(1);
    }    
    if(send(sock, &c4, sizeof(c4), 0) < 0) {
        puts("Send failed");
        exit(1);
    }
    
    
}
