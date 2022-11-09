#include <stdio.h>
 
struct etudiant{
    char prenom[20];
    int age;
};
int main(void){
 
    // pointeur et1 de type etudiant
    struct etudiant *et1;
    struct etudiant et2;
 
    // initialisation
    et1=&et2;
 
    printf("Saisir votre prénom : ");
    scanf("%s",&et1->prenom);
 
    printf("saisir votre age : ");
    scanf("%d",&et1->age);
 
    printf(" voici vos infos : ");
    printf(" Prénom : %s",et1->prenom);
    printf(" age : %d",et1->age);

    printf(" bogey : ");
    printf(" Prénom : %s",et2.prenom);
    printf(" age : %d",et2.age);
 
    return 0;
}