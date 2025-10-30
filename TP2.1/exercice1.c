#include <stdio.h>
//1
void affiche_nombres( int n){
  int compteur = 1;
  printf("%d: ", n);
  while(compteur <= n ){
    printf("%d ", compteur);
    compteur++;
  }
  printf("\n");
}

void affiche_nombres_decroissant(int n){
	int compteur = n;
	printf("%d: ", n );
	while( compteur >= 1 ){
		printf("%d ", compteur );
		compteur--;
	}
}

//2
void affiche_carres( int n){
	int compteur = 1;
	while(compteur * compteur <= n ){
	    printf( "%d ", compteur * compteur);
	    compteur++;
	}
	printf("\n");
}

//3
 void affiche_carres_entre(int n, int m){
 	int compteur = 1;
	while( compteur*compteur > n && compteur*compteur<m){
	    printf("%d ", compteur*compteur);
	    compteur++;
	}
	printf("\n");
} 
	
//4
int saisie_valeur(){
    int valeur=0;
    printf("entrez une valeur:");
    scanf("%d", &valeur);
    while (valeur < 0 || 3 < valeur){
        printf("entrez une valeur: ");
        scanf("%d ",&valeur);
       }
       return valeur;
}
    	
 
 		
 		
 	


int main(){
 affiche-nombres(6);
  return 0;
}
