//including libraries
#include "cliente.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>

//declaration of variables that will be sent to the server
char c1='A';
char c2='B';
char c3='C';
char c4='D';
int i = 16;

//pointer on i
char *pointeur = (char *) &i;

//prototype of the function send_integer
void send_integer(int sock,int integer);

//main
int main(int argc, char *argv[])
{

    //sending the 1st char using a socket, then closing it
    int sock = connection();
    send_integer(sock,c1);
    close(sock);

    //sending the 2nd char with an other socket
    sock = connection();
    send_integer(sock,c2);
    close(sock);

    //Here we want to send the data using big endian. To do so, we will using the pointer on the value of I
    //we will first send the last byte, then the other to use big endian
    //sending the 4th byte of the int
    sock = connection();
    send_integer(sock,pointeur[3]);
    close(sock);

    //sending the 3rd byte of the int
    sock = connection();
    send_integer(sock,pointeur[2]);
    close(sock);

    //sending the 2nd byte of the int
    sock = connection();
    send_integer(sock,pointeur[1]);
    close(sock);

    //sending the 1st byte of the int
    sock = connection();
    send_integer(sock,pointeur[0]);
    close(sock);

    //sending the 3rd char
    sock = connection();
    send_integer(sock,c3);
    close(sock);

    //sending the 4th char
    sock = connection();
    send_integer(sock,c4);
    close(sock);
    return 0;
}

//sent integer function, that allows to send data using a socket
void send_integer(int sock,int integer)
{
    //sending data
    if(send(sock, &integer, sizeof(c1), 0) < 0) {
        puts("Send failed");
        exit(1);
    }    
    
}
