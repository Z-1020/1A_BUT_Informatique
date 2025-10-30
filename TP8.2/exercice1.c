#include <stdio.h>

//1
int longueur(char chaine[]){
	int compteur=0;
	while(chaine[compteur]!='\0'){
		compteur++;
	}
	return compteur;
}

int expression(char chaine[]){
	int compteur=0;
	while(chaine[compteur]!='\0'){
		compteur++;
	}
	int paranth=0;
	for(int compteur2=0; compteur2<compteur; compteur2++){
		if(chaine[compteur2]=='('){
			paranth++;
		}
		else if(chaine[compteur2]==')'){
			paranth--;
		}
	}
	if(paranth==0){
        return 1;
    }
    else if(paranth!=0){
        return 0;
    }
}

//2
test_expression(){
    char chaine1[]="(a+b*(a-y))";
    char chaine2[]="(a-b+(c-d)";
    int nb_paranth1=expression(chaine1);
    int nb_paranth2=expression(chaine2);
    if(nb_paranth1==1 && nb_paranth2==0){
        printf("fonctionne\n");
    }
    else{
        printf("ne fonctionne pas\n");
    }
}

int main(){
    test_expression();
}