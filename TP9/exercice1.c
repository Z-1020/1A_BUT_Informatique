#include <stdio.h>
#define TAILLE_MAX 30

//1
struct date{
    int jour;
    int mois;
    int annee;
};

struct personne{
    char nom[TAILLE_MAX];
    char prenom[TAILLE_MAX]; 
    struct date naissance;
};

//2

void affiche_personne(struct personne p1, struct date naissance){
    printf("%s %s %d/%d/%d", p1.nom, p1.prenom, naissance.jour, naissance.mois, naissance.annee);
}

//3

void lire_personne(struct personne p2, struct date naissance){
    printf("entrez votre prénom :");
    int compteur=0;
    while(p2.prenom[compteur]!= '\n'){
        scanf("%c", p2.prenom);
        compteur++;
    }
    int compteur2=0;
    printf("entrez votre nom :");
    while(p2.nom[compteur2]!= '\n'){
        scanf("%c", p2.nom);
        compteur2++;
    }
    int compteur3=0;
    printf("entrez le jour de naissance :");
    while(compteur3<2){
        scanf("%d", &naissance.jour);
        compteur3++;
    }
    int compteur4=0;
    printf("entrez le mois de naissance :");
    while(compteur<2){
        scanf("%d", &naissance.mois);
        compteur4++;
    }
    int compteur5=0;
    printf("entrez l'année de naissance :");
    while(compteur5<2){
        scanf("%d", &naissance.annee);
        compteur5++;
    }


}

int main(){
    struct date naissance;
    struct personne p1={};
    lire_personne(p1, naissance);
}