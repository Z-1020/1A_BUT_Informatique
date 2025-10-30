#include <stdio.h>
void seconde_vers_horaire(int* seconde, int* heure, int* minute, int ecoule){
	*heure= ecoule/3600;
	*minute=(ecoule/60-*heure*60);
	*seconde = ecoule -*minute*60 -*heure*3600;
	printf("%d h %d m %d s\n", *heure, *minute, *seconde);
}
	
int main(){
	int ecoule,heure,seconde,minute;
	printf("veuillez entrer une valeur\n");
	scanf("%d", &ecoule);
	seconde_vers_horaire(&seconde, &heure, &minute, ecoule);
}

	
	
