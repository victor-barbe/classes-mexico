//importing libraries
#include "server.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>

//variables iniciated to a value, to check if the program worked properly
char c1='U';
char c2='U';
char c3='U';
char c4='U';
int i=-1;
//pointer for the int
char *pointeur = (char *) &i;

//prototype of the function recv_integer
int recv_integer(int client_sock);

//prototype of the function display 
void display();

//main 
int main(int argc, char *argv[])
{
    int socket_desc = initialization();
    int counter=0;
    
	//infinite loop
    while(1) {
	//declaring variables used to get the data
    int client_sock = connection(socket_desc);
	int socket_desc = initialization();
	int integer = recv_integer(client_sock);

	//getting value by value 
	printf("counter: %d\n",counter);
	//getting 1st char from the socket, takes the value of integer that takes the value of the data in the socket
	if(counter==0)
	{c1=integer;
	}
	//getting 2nd char
	if(counter==1)
	{c2=integer;
	}
	//getting the int byte by byte to get the int back into little endian after sending it in big endian
	if(counter==2)
	{
	pointeur[3] = integer;
	}
		if(counter==3)
	{
	pointeur[2] = integer;
	}
		if(counter==4)
	{
	pointeur[1] = integer;
	}
		if(counter==5)
	{
	pointeur[0] = integer;
	}
	//getting 3rd char
	if(counter==6)
	{c3=integer;
	}
	//getting 4th char
	if(counter==7)
	{c4=integer;
	}
	counter = counter + 1;
	display();
    }
	//closing the socket
    close(socket_desc);
    return 0;
}

//function to display data
void display()
{
	printf("c1 : %c\n",c1);
	printf("c2 : %c\n",c2);
	printf("i : %d\n",i);
	printf("c3 : %c\n",c3);
	printf("c4 : %c\n",c4);
}

//function to recieve data using the socket
int recv_integer(int client_sock)
{
    int read_size, integer;
    
    // receive a message from client
    read_size = recv(client_sock, &integer, sizeof(integer), 0);
    
    if(read_size == 0) {
        puts("Client disconnected");
        fflush(stdout);
    }
    else if(read_size == -1) {
        perror("recv failed");
    }
    
    return integer;
}
