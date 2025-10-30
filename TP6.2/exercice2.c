#include <stdio.h>

//1

int demande_joueur(){
	int nb_allumette=0;
	printf("entrez un nombre : ");
	scanf("%d", &nb_allumette);
	while(nb_allumette!=1 && nb_allumette!=2 && nb_allumette!=3){
		printf("entrez un nombre : ");
		scanf("%d\n", &nb_allumette);
		if(nb_allumette==1 || nb_allumette==2 || nb_allumette==3){
			return nb_allumette;
		}
	}
	if(nb_allumette==1 || nb_allumette==2 || nb_allumette==3){
		return nb_allumette;
	}
}

//2
int demande_deux_joueur(int nb_allumette){
	int joueur1=demande_joueur;
	int joueur2=demande_joueur;
	nb_allumette=joueur1-joueur2;
	for(allumette; i>=0; i--){
		joueur1=demande_joueur;
		joueur2=demande_joueur;
		nb_allumette=joueur1-joueur2;
	}
}



//3
int bot_idiot( int nb_allumette){
	int entier=rand()%3;
}

//4
int super_bot(){
		

int main(){
	printf("%d\n", demande_joueur());
} 
