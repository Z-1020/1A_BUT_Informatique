#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//1
void affiche_tableau(int tab[], int taille){
	 for (int i=0; i<taille; i++){
	 	printf("%d\n", tab[i]);
	 }
} 

//2
/*void saisir_valeur(int tab[], int taille){
	int n;
	printf("entrez une valeur\n");
	scanf("%d", &n);
	for(int compteur=0; compteur<n-1; compteur++){ 	
		printf("entrez une valeur\n");
		scanf("%d", &n);
		for (int i=0; i<taille; i++){
	 		tab[i]=n;
	 		printf("%d\n", tab[i]);
	 	}
	 }
} 
*/
void saisir_valeur(int tab[], int taille){
	for (int i=0; i<taille; i++){
		int n;
		printf("entrez une valeur");
		scanf("%d", &n);
	 	tab[i]=n;
	 	printf("%d\n", tab[i]);
	 }		
}
	
	
//3
void remplit_aleatoirement(int tab[], int taille){
	for(int i=0; i<taille; i++){
		int aleatoire=rand();
		tab[i]=aleatoire;
	}
}
/*
//4
int plus_grande_valeur(int tab[], int taille){
	for(int i=0; i<taille; i++){
		int val=0;
		int val_max=0;
		tab[i]=val_max;
		tab[i+1]=val;
		if(val>val_max){
			val=val_max;
		}
	}
	return val_max;
}
*/			
//5		
int recherche_nombre(int tab[], int taille, int entier){
	for(int i=0; i<taille; i++){
		if(tab[i]==entier){
			return entier;
		}
	}
	return 0;
}		

int test_recherche(){
	int tab[5]={6,5,2,4,8};
	if(recherche_nombre(tab, 5, 2)==3){
		return 1;
	}
	else{
		return 0;
	}
}		
	
//6
int sup_dix(int tab[], int taille){
	int cpt=0;
	for(int i=0; i<taille; i++){
		if(tab[i]>=10){
			cpt++;
		}
	}
	return cpt;
} 

//7
int croissant(int tab[], int taille){
	for(int i=0; i<taille; i++){
		if(tab[i+1] > tab[i]){
			return 0;
		}
	}
	return 1;
}

//8
int somme(int tab[], int taille){
	for(int i=0; i<taille; i++){
		int somme=0;
		somme+=tab[i];
	}
}

int test_somme(){
	int tab[5]={1,2,3,4,5};
	if(somme(tab, 5)==15){
		return 1;
	}
	else if(somme(tab, 5)!=15){
		return 0;
	}
}


	
int main(){
	int tab[5]={1,2,3,4,5};
	printf("%d\n",test_somme());
}

