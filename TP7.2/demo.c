#include <stdio.h>

void enchaine_les_scanf();


int main(){
	char tab1[4] = "ah";
	char tab2[10] ="bonjour";

	printf("chaine 1: %s, chaine 2: %s\n",tab1, tab2);
	scanf("%s", tab1); 
	// Tester en entrant une chaîne courte (e.g. bla)
	// Puis tester à nouveau en entrant une chaîne longue (e.g. bulbizarre)
	printf("chaine 1: %s, chaine 2: %s\n",tab1, tab2);
	return 0; 
	
}
