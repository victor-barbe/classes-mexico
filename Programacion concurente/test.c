#include <stdio.h>
#include <math.h>

struct mastructure
{
    int longueur;
    int largeur;
};


int return_square(int value)
{
    int squared_value = value * value;
    return(squared_value);
}

float return_sqrt(int value)
{
    float squared = sqrt(value);
    return(squared);
}

int * array_returner()
{
    static int r[15];
    size_t n = sizeof(r) / sizeof(int);
    for (int j = 0 ; j < n ; j++)
    {
        r[j] = j;
    }

    return r;
}

int main()
{
    //int a = return_square(4);
    //float b = return_sqrt(12);
    //printf("%d ", a);
    //printf("%f ", b);

    int* p;

    p = array_returner();
	
    for ( int i = 0; i < 10; i++ ) {
        printf( "%d \n", p[i]);
    }

    struct mastructure s1;
    s1.largeur = 21;
    s1.longueur = 12;
    printf("%d ", s1.largeur);
    printf("%d ", s1.longueur);

    struct mastructure s2 = {12,14};

    printf("%d ", s2.largeur);
    printf("%d ", s2.longueur);

    
}
