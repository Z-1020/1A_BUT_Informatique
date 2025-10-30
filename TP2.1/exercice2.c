#include <stdio.h>

//1

int est_premier( int n){
	int compteur = 1;
	while(compteur <= n){
		if(n% compteur ==0){
			printf("%d ", compteur);
		}
		compteur++;
	}
	printf("\n");
}

int premier_plus_petit(int n){
	int compteur=1;
	int compteur2=2;
	while(compteur <n){
		while(compteur2 < n){
			if(n/compteur==compteur && n%compteur2!=0){
				printf("%d ", compteur);
			}
			compteur2++;
		}
		compteur++;
	}
} 

int main(){
	printf("%d", premier_plus_petit(10));
	return 0;
}
