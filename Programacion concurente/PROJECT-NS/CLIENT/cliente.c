// store messages using a service

#include "cliente.h"

int sock;                       // server socket
char * host = "127.0.0.1";      // server name

int main( int argc, char * argv[] )
{
	char * m;

	if( argc != 3 ) {
	    fprintf( stderr,
	        "Uso: %s <service> <mensaje>\n", argv[0] );
	    exit( 1 );
	}

	m = argv[2];
    
    int port = find_service(atoi(argv[1]));
    sock = connection(port);        // remote invocation
    
	int result = store( m );        // as if it was a local call!
    printf("Resultado recibido por el cliente: %d\n", result);

	printf( "El mensaje fue almacenado\n" );
    close(sock);
    return 1;
}
