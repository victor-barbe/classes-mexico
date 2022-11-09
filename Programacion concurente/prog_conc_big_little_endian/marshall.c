#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int main ()
{
char c1 = 'A';
char c2 = 'B';
int i = 16;		// entero a 32 bits representado en LITTLE-ENDIAN
char c3 = 'C';
char c4 = 'D';
char *pointeur = (char *) &i;
//printf("%d",&pointeur);

FILE *p;
p=fopen("file.bin","w");
if (p == NULL)
    {
        puts("Couldn't open file");
        exit(0);
    }
    else
    {
        fputc(c1, p);
        fputc(c2, p);
        fputc(pointeur[3],p);
        fputc(pointeur[2],p);
        fputc(pointeur[1],p);
        fputc(pointeur[0],p);
        fputc(c3, p);
        fputc(c4, p);
        //puts(" \n Done");
        fclose(p);
    }
fclose(p);

}