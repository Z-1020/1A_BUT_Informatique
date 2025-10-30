#include <stdio.h>
//1
void affiche_nombres(int n){
	int i = 1;
	for(i=1; i<=n;i+=1){
		printf("%d ", i);
	}
	printf("\n");
}
//2
void affiche_nombres_pairs(int n){
	int i;
	for(i=0;i<=n;i+=2){
		printf("%d ", i);
	}
	printf("\n");
}
//3
void affiche_nombres_decroissant( int n){
	for(int i = n; i>0;i-=1){
		printf("%d ", i);
	}
	printf("\n");
}


int main(void){
	affiche_nombres_decroissant( 100);
	return 0;
}
	
	
