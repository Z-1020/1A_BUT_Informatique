#include <stdio.h>
#define Max_Domino 6;

void affiche_domino(){
	int nb_min=0;
	int nb_sup=0;
	for(nb_min=0; nb_min<=6; nb_min++){
		 for(nb_sup = 0; nb_sup<=6; nb_sup++){
		 	printf("[%d, %d]", nb_min , nb_sup);
		 }
		printf("\n");
	}
}

void domino_sans_doublons(){
	int nb_min=0;
	int nb_sup=0;
	for(nb_min=0; nb_min<=6; nb_min++){
		 for(nb_sup = 0; nb_sup<=6; nb_sup++){
		 	if(nb_sup>nb_min || nb_sup==nb_min){
		 		printf("[%d, %d]", nb_min , nb_sup);
		 	}
		 }
		printf("\n");
	}
}
void affiche_dominos_egal_a( int total){
	int cote=3;
	int nb_min=0;
	int nb_sup=0;
	for(nb_min=0; nb_min<=6; nb_min++){
		 for(nb_sup = 0; nb_sup<=6; nb_sup++){
		 	if((nb_sup>=cote || nb_min>=cote) && nb_min+nb_sup==total && nb_sup>nb_min){
		 		printf("[%d, %d]\n", nb_min , nb_sup);
		 	}
		 }

	}
}
void total_dominos(int somme){
	int nb_min=0;
	int nb_sup=0;
	int max=Max_Domino;
	int somme_dominos=0;
	if(somme==0){
		for(nb_min=0; nb_min<=max; nb_min++){
		 	for(nb_sup = 0; nb_sup<=max; nb_sup++){
		 		if(nb_sup>nb_min || nb_min==nb_sup){
		 			int dominos = nb_sup + nb_min;
		 			somme_dominos=somme_dominos+dominos;
		 		}
		 	}
		}
		printf("%d\n", somme_dominos);
	}
	else if(somme>0){
		for(nb_min=0; nb_min<=max; nb_min++){
		 	for(nb_sup = 0; nb_sup<=max; nb_sup++){
		 		if((nb_sup%2==0 || nb_min%2==0)  && (nb_sup>nb_min || nb_min==nb_sup)){
		 			int dominos = nb_sup + nb_min;
		 			somme_dominos=somme_dominos+dominos;
		 		}
			}
		}
			printf("%d\n", somme_dominos);	
	}
	else{
		for(nb_min=0; nb_min<=max; nb_min++){
		 	for(nb_sup = 0; nb_sup<=max; nb_sup++){
		 		if((nb_sup%2==1 || nb_min%2==1) && (nb_sup>nb_min || nb_min==nb_sup)){
		 			int dominos = nb_sup + nb_min;
		 			somme_dominos=somme_dominos+dominos;
		 		}
			}
		}
			printf("%d\n", somme_dominos);
	}
}
		

		
int main(){
	total_dominos(0);
	return 0;
}
