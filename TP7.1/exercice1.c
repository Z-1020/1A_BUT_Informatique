#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define TAILLE_MAX_TABLEAU  8

//Exercice1

//1

void affiche_tableau(int tableau[], int taille){
	printf("[");
	for(int i=0; i<taille; i++){
		printf("%d,", tableau[i]);
	}
	printf("]\n");
}

void test_affiche_tableau() {
	int tableau[]={1,3,5,8,5,9,4,6};
	affiche_tableau(tableau, TAILLE_MAX_TABLEAU); 
}

//2

void recopie_tableau(int tableau1[], int taille1, int tableau2[], int taille2){
    for(int compteur1=0; compteur1<taille1; compteur1++){
            tableau2[compteur1]=tableau1[compteur1];
            printf("%d,", tableau2[compteur1]);
    }
}

void test_recopie_tableau(){
    int tableau1[]={0,2,3,7,6,4,4,9};
    int tableau2[TAILLE_MAX_TABLEAU];
    recopie_tableau(tableau1, TAILLE_MAX_TABLEAU, tableau2, TAILLE_MAX_TABLEAU);
}
//3

void remplir_aleatoirement(int tableau[], int taille){
    for(int compteur=0; compteur<taille; compteur++){
        int aleatoire;
        aleatoire=rand();
        tableau[compteur]=aleatoire;
    }
}

void test_remplir_aleatoirement(){
    int tableau[TAILLE_MAX_TABLEAU];
    remplir_aleatoirement(tableau, TAILLE_MAX_TABLEAU);
    affiche_tableau(tableau, TAILLE_MAX_TABLEAU);
}

//Exercice2

//1

void passage_bulle(int T[], int taille){
    int temp;
    for(int i=0; i<taille-1; i++){
        if(T[i]>T[i+1]){
            temp=T[i];
            T[i]=T[i+1];
            T[i+1]=temp;
        }
   }
}

void tri_a_bulle(int T[], int taille){
    for(int i=0; i<taille; i++){
        passage_bulle(T, taille);
    }
}

void test_tri_a_bulle(){
    int taille=0;
    taille=TAILLE_MAX_TABLEAU;
    int T[taille];
    remplir_aleatoirement(T, taille);
    tri_a_bulle(T, taille);
    affiche_tableau(T, taille);
}
//2 et 3

//4

int passage_bulle_V2(int T[], int taille){
    int temp;
    int est_trie=1;
    for(int i=0; i<taille; i++){
        if(T[i+1]<T[i]){
            temp=T[i];
            T[i]=T[i+1];
            T[i+1]=temp;
            est_trie=0;
        }
    }
}

void tri_a_bulle_V2(int T[], int taille){
    for(int i=0; i<taille; i++){
        passage_bulle_V2(T, taille);
        if(passage_bulle_V2(T, taille)==0){
            break;
        }
    }
}

void test_tri_a_bulle_V2(){
    int taille=0;
    taille=TAILLE_MAX_TABLEAU;
    int T[taille];
    remplir_aleatoirement(T, taille);
    tri_a_bulle_V2(T, taille);
    affiche_tableau(T, taille);
}

//5

void tri_bulle_V3(int T[], int taille){
    for(int i=0; i<taille; i++){
        if(passage_bulle_V2(T, taille-1)==0){
            break;
        }
    }
}
void test_tri_a_bulle_V3(){
    int taille=0;
    taille=TAILLE_MAX_TABLEAU;
    int T[taille];
    remplir_aleatoirement(T, taille);
    tri_bulle_V3(T, taille);
    affiche_tableau(T, taille);
}

int main(){
    clock_t temps_initial,
    temps_final;
    double temps_exec;
    temps_initial = clock ();
    test_tri_a_bulle_V3();
    temps_final = clock();
    temps_exec = (temps_final - temps_initial) * 1e-6;
    printf("temps d'execution %E\n", temps_exec); 
	return 0;
}
