
#include "servidor.h"

void register_service(int id, int port);

char * recv_message(int client_sock);
void send_result(int client_sock, int value);

int main(int argc, char *argv[])
{
    if( argc != 2 ) {
        fprintf( stderr,
                "Uso: %s <id-servicio>\n", argv[0] );
        exit( 1 );
    }
    
    register_service( atoi(argv[1]), SERVICE_PORT);
    int socket_desc = initialization(SERVICE_PORT);
    
    while(1) {
        int client_sock = connection(socket_desc);
        char * m = recv_message(client_sock);
        
        int value = store(m);
        free(m);
        send_result(client_sock, value);
    }
    
    close(socket_desc);
    return 0;
}

void register_service(int id, int port)
{
    int proc = 1;                          // id del servicio
    int sock = portmapper("127.0.0.1");
    
    send(sock, &proc, sizeof(proc), 0);
    send(sock, &id, sizeof(id), 0);
    
    if(send(sock, &port, sizeof(port), 0) < 0) {
        puts("Send failed");
        exit(1);
    }
    
    close(sock);
}

char * recv_message(int client_sock)
{
    char * message;
    int read_size, length;
    
    // receive the message length from client
    read_size = recv(client_sock, &length,
                                  sizeof(length), 0);
    
    // dynamic memory allocation to store the message
    message = (char *) malloc(length);
    read_size = recv(client_sock, message, length, 0);
    
    if(read_size == 0) {
        puts("Client disconnected");
        fflush(stdout);
    }
    else if(read_size == -1) {
        perror("recv failed");
    }
    
    return message;
}

void send_result(int client_sock, int value)
{
    printf("server_result: %d\n", value);
    
    // send result to the client
    if(send(client_sock, &value, sizeof(value), 0) < 0) {
        puts("Send failed");
        exit(1);
    }
}
