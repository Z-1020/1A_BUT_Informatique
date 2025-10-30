#include <stdio.h>

//1
int sont_valeurs_positives(int tableau[], int taille){
	int compteur=0;
	for(int i=0; i<taille; i++){
		if(tableau[i]>=0){
			compteur++;
		}
	}
	if(compteur==taille){
		return 1;
	}
	else{
		return 0;
	}
}
		
void test_valeur(){
	int tab[5]= {1,2,6,5,8};
	int tab2[5]= {1,-5,6,7,2};
	if(sont_valeurs_positives(tab, 5)==1 && sont_valeurs_positives(tab2, 5)==0){
		printf("fonctionne\n");
		}
	else{
		printf("ne fonctionne pas\n");
	}
}


//2

int compte_nombres_avant_moins1(int tab[], int taille){
	int i=0;
	while(i<taille){
		if(tab[i]!=-1){
			i++;
		}
		else if(tab[i]==-1){
			return i;
		}
	}
	return -1;
}
	 
void test_compte(){
	int tab1[6]={1,2,3,4,5,6};
	int tab2[6]={1,-1,6,8,7,8};
	int tab3[4]={3,5,6,-1};
	if(compte_nombres_avant_moins1(tab1, 6)==-1 && compte_nombres_avant_moins1(tab2, 6)==1 && compte_nombres_avant_moins1(tab3, 4)==3){
		printf("fonctionne\n");
	}
	else{
		printf("ne fonctionne pas\n");
	}
}

		
int main(){
	int tab[6]={1,2,3,4,-1,6};
	printf("%d\n",compte_nombres_avant_moins1(tab, 6));
	test_compte();
} 
