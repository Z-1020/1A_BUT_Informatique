#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//1
int devinette(){
	return rand()%1000 +1;
}

//2
void demande_devinette(){
	int nb_joueur = 0;
	int nb_ordinateur = devinette();
	int compteur = 1;
	printf("entrez une valeur: ");
	scanf("%d", &nb_joueur);
	printf("\n");
	while( nb_ordinateur != nb_joueur){
		if(nb_joueur < nb_ordinateur){
			printf("c'est plus grand ");
			printf("\n");
			printf("entrez une valeur: ");
			scanf("%d",&nb_joueur);
			printf("\n");
			compteur++;
		}
		else{
			printf("c'est plus petit ");
			printf("\n");
			printf("entrez une valeur: ");
			scanf("%d",&nb_joueur);
			printf("\n");
			compteur++;
		}
	}
	printf("gagné le nombre selectionne par l'ordi est : %d\n", nb_ordinateur);
	printf("votre nombre de tour est de : %d", compteur);
	printf("\n");
}
		
	

int main(){
	srand( time(NULL));
	demande_devinette();
	return 0;
}
