#include <stdio.h>
#include <stdlib.h>

//exercice1

//1

int longueur(char chaine[]){
	int compteur=0;
	while(chaine[compteur]!='\0'){
		compteur++;
	}
	return compteur;
}

//2

void test_longueur(){
	char chaine1[]="bonjour tout le monde";
	char chaine2[]="bonsoir";
	if(longueur(chaine1)==21 && longueur(chaine2)==7){
		printf("la fonction est correct\n");
	}
	else{
		printf("erreur\n");
	}
}
//3

void en_minuscule(char chaine[]){
	int compteur=0;
	int num_caractere=0;
	while(chaine[compteur]!='\0'){
		if(chaine[compteur]<='z'){
			num_caractere=chaine[compteur]-'a'+'A';
			char caractere=num_caractere;
			chaine[compteur]=caractere;
			printf("%c", chaine[compteur]);
		}
		else{
			printf("%c", chaine[compteur]);
		}
	}
}



//4
/*/
int lire_chaine_protege(int longueur, int tab[]){
	char chaine;
	int longueur_chaine=0
	printf("entrez une chaine de caractere : ");
	scanf("%s", &chaine);
	longueur_chaine=longueur(chaine);
	for(int i=0; i>longueur; i++){
		if(longueur>=longueur_chaine){
			tab[i]=chaine[i];
		}
		else{
}			
/*/

//exercice2

//1		
	
int frequent(char chaine[]){
	char chaine[]="bonjour";
	longueur(chaine[]);
	int compteur=0;
	int compteur2=0;
	for(compteur=0; compteur<longueur(chaine); compteur++){
		if(chaine[compteur]==chaine[compteur+1]){
			compteur2++;
		}
	}
	return compteur2;
}







int main(){
	char chaine[]="bonjour";
	printf("%d\n", frequent(chaine));
	return 0;
}

