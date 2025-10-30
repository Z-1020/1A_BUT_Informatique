#include <stdio.h>

//exercice 1
//1

enum jour {LUNDI, MARDI, MERCREDI, JEUDI, VENDREDI, SAMEDI, DIMANCHE};

//2

void affiche_jour(enum jour semaine){
	switch(semaine){
		case LUNDI:
			printf("Lundi\n");
			break;
		case MARDI:
			printf("Mardi\n");
			break;
		case MERCREDI:
			printf("Mercredi\n");
			break;
		case JEUDI:
			printf("Jeudi\n");
			break;
		case VENDREDI:
			printf("Vendredi\n");
			break;
		case SAMEDI:
			printf("Samedi\n");
			break;
		case DIMANCHE:
			printf("Dimanche\n");
			break;
	};
}

//3

struct date {
	int jour;
	enum mois {JANVIER, FEVRIER, MARS, AVRIL, MAI, JUIN, JUILLET, AOUT, SEPTEMBRE, OCTOBRE, NOVEMBRE, DECEMBRE};
	int annee;
};

struct date cree_date(int jour, enum mois, int annee){
	struct date d={jour,mois,annee};
	return d;
}
void affiche_date(struct date d){
	printf("%02d/%02d/%4d", d.jour, d.mois, d.annee);
}


int main(){
	struct date d={11,JANVIER,2023};
	affiche_date(date d);
	return 0;
}
