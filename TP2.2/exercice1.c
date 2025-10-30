#include <stdio.h>
# include <stdlib.h>
# include <time.h>

//1
int lance_un_de(){
	return (rand()%6)+1;
}

//2
void lance_1000(){
	int compteur_1=0;
	int compteur_2=0;
	int compteur_3=0;
	int compteur_4=0;
	int compteur_5=0;
	int compteur_6=0;
	for(int i = 0; i< 1000; i++){
		 int de = lance_un_de();
		 if(de==1){
		 	compteur_1++;
		 }
		 else if(de==2){
		 	compteur_2++;
		}
		else if(de==3){
		 	compteur_3++;
		}
		else if(de==4){
		 	compteur_4++;
		}
		else if(de==5){
		 	compteur_5++;
		}
		else if(de==6){
		 	compteur_6++;
		}
	}
	printf("1000 tirage:\n");
	printf("1 : \n%d",compteur_1);
	printf("2 : %d\n",compteur_2);
	printf("3 : %d\n",compteur_3);
	printf("4 : %d\n",compteur_4);
	printf("5 : %d\n",compteur_5);
	printf("6 : %d\n",compteur_6);	
}

//3

void lance_de(){
	printf("entrez le nombre de lancer");
	int nb_lancer =0;
	scanf("%d", &nb_lancer);
	int compteur_1=0;
	int compteur_2=0;
	int compteur_3=0;
	int compteur_4=0;
	int compteur_5=0;
	int compteur_6=0;
	for(int i = 0; i< nb_lancer; i++){
		 int de = lance_un_de();
		 if(de==1){
		 	compteur_1++;
		 }
		 else if(de==2){
		 	compteur_2++;
		}
		else if(de==3){
		 	compteur_3++;
		}
		else if(de==4){
		 	compteur_4++;
		}
		else if(de==5){
		 	compteur_5++;
		}
		else if(de==6){
		 	compteur_6++;
		}
	}
	printf(" tirage: %d\n",nb_lancer);
	printf("1 : %d\n",compteur_1);
	printf("2 : %d\n",compteur_2);
	printf("3 : %d\n",compteur_3);
	printf("4 : %d\n",compteur_4);
	printf("5 : %d\n",compteur_5);
	printf("6 : %d\n",compteur_6);	
}
//4

void lance_de2(){
	printf("entrez le nombre de lancer : ");
	int nb_lancer =0;
	scanf("%d", &nb_lancer);
	int max = 0;
	int de;
	for(int i = 0; i< nb_lancer; i++){
	
		de = lance_un_de(10);
		if(max < de){
		 	max = de;
		 }
		
	}
	printf("max : %d\n", max);
}

//5
void somme_lancer(){
	printf("entrez le nombre de lancer : ");
	int nb_lancer = 0;
	scanf("%d", &nb_lancer);
	int somme = 0;
	for( int i =0; i< nb_lancer; i++){
		int de = lance_un_de();
		printf("%d",de);
		somme = somme + de;
	}
	printf("%d\n", somme);
}

//6
int longueur_lancer(){
	printf("entrez le nombre de lancer : ");
	int nb_lancer = 0;
	scanf("%d", &nb_lancer);
	int de =0;
	int de_precedent =0;
	int longueur_max = lance_un_de();
	for(int i =0;  i<nb_lancer-1; i++){
		de = lance_un_de();
		
		if(de == de_precedent && de > longueur_max){
			longueur_max = de;
		}
		else if( de > de_precedent && de >longueur_max){
			longueur_max = de;
		}
		
		de_precedent = de;
		
	}
	return longueur_max;
}			


	
//fonction main
int main(){
	srand(time (NULL));
	printf("%d",longueur_lancer(5));
	return 0;
}

