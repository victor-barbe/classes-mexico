#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <arpa/inet.h>
#include <sys/socket.h>

#define PORTMAPPER 1111

// utilities

int connection(int port);
int close(int sock);

// remote services

int store( char * m );
int find_service(int id);
