
#include "server.h"

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>

char c1='U';
char c2='U';
char c3='U';
char c4='U';
int i=-1;


int recv_integer(int client_sock);

void display();

int main(int argc, char *argv[])
{
    int socket_desc = initialization();
    int count=0;
    
    
    while(1) {
        
        int client_sock = connection(socket_desc);
        for (int j=0;j<5;j++)
        {
        	int socket_desc = initialization();
		int integer = recv_integer(client_sock);
		printf("integer: %ls\n", &integer);
		printf("count: %d\n",count);
		if (count==0)
		{c1=integer;
		}
		if(count==1)
		{c2=integer;
		}
		if(count==2)
		{i=integer;
		}
		if(count==3)
		{c3=integer;
		}
		if(count==4)
		{c4=integer;
		}
		count++;
		display();
        }
    }
    printf("%d\n",count);
    
    close(socket_desc);
    return 0;
}

void display()
{
	printf("c1 : %c\n",c1);
	printf("c2 : %c\n",c2);
	printf("i : %d\n",i);
	printf("c3 : %c\n",c3);
	printf("c4 : %c\n",c4);
}

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
