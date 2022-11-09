#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int main (){
char c1 = 'U';
char c2 = 'U';
long i = -1;		// entero a 64 bits representado en LITTLE-ENDIAN
char c3 = 'U';
char c4 = 'U';
char *pointeur = (char *) &i;

FILE *p;

p=fopen("file.bin","r");
if (p == NULL)
    {
        puts("Couldn't read file");
        exit(0);
    }
    else
    {
        c1 = fgetc(p);
        c2 = fgetc(p);
        pointeur[3] = fgetc(p);
        pointeur[2] = fgetc(p);
        pointeur[1] = fgetc(p);
        pointeur[0] = fgetc(p);
        c3 = fgetc(p);
        c4 = fgetc(p);
        //puts("Done");
        fclose(p);
    }

pointeur[4] = 0;
pointeur[5] = 0;
pointeur[6] = 0;
pointeur[7] = 0;

fclose(p);
printf("%c \n",c1);
printf("%c \n",c2);
printf("%ld \n",i);
printf("%c \n",c3);
printf("%c \n",c4);


}