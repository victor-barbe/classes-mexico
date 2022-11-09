#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

#define PORTMAPPER 1111
#define SERVICE_PORT 7777

// utilerias

int portmapper(char * host);        // conexión con servidor de nombres
int initialization();               // inicialiación del servicio
int connection(int socket_desc);    // esperar a los clientes
int close(int sock);

// servicio(s)

int store(char * m);
