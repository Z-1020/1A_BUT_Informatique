#include <stdio.h>
void plus_grande_valeur(){
	int nb_saisi;
	int val;
	int val_max=0;
	int compteur=0;
	printf("veuillez entrer le nombre de valeur à saisir : ");
	scanf("%d",&nb_saisi);
	for(int i=1; i<=nb_saisi; i++){
		printf("entrez une valeur : ");
		scanf("%d",&val);
		if(val>val_max){
			val_max=val;
			compteur++;
		}
	}
	printf("%d, %d valeur entrée\n", val_max, compteur++);
}
//3
void valeur_negative(int nb_saisi){
	int val;
	int val_max=0;
	int compteur=0;
	for(int i=0; i<nb_saisi; i++){
		if(val>=0){
		printf("entrez une valeur : ");
		scanf("%d",&val);
			if(val>val_max){
			val_max=val;
			compteur++;
			}
		}
	}
	printf("%d %d eme valeur\n", val_max, compteur);
}
int main(){
	valeur_negative(5);
}

