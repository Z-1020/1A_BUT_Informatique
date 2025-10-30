#include <stdio.h>

/*
void est_mot_palindromique(char s[]){
    	int compteur=0;
	while(s[compteur]!='\0'){
		compteur++;
	}
    char chaine[]="";
    char chaine2[]="";
    int compteur3=0;
    int m_compt=0;
    int nb_lettre=0;
    if(compteur%2==0){
        m_compt=compteur/2;
    }
    else{
        m_compt=compteur/2+1;
    }
    for(compteur3=0; compteur3<m_compt; compteur3++){
        chaine[compteur3]=s[compteur3];
        printf("%c", chaine[compteur3]);
    }
    for(int compteur4=compteur; compteur4>=m_compt; compteur4--){
        chaine2[compteur4]= s[m_compt-compteur4];
        printf("%c", chaine2[compteur4]);
    }
}
*/
/*
void est_palindrome(char s[]){
    int compteur=0;
	while(s[compteur]!='\0'){
		compteur++;
	}
    int compteur2=0;
    for(int i=0; i<compteur; i++){
        if(s[i]==s[compteur-i]){
            compteur2++;
        }
    }
}

*/


int longueur(char s[]){
	int compteur=0;
	while(s[compteur]!='\0'){
		compteur++;
	}
	return compteur;
}

void mot_palindrome(char s[]){
	int l=longueur(s);
	int compteur=0;
	for(int i=0; i<l; i++){
		if(i!=l/2+1){
			if(s[i]==s[l-i]){
				compteur++;
			}
		}
	}
	printf("%d\n",compteur);
}

int main(){
	char s[]="radar";
	mot_palindrome(s);
	return 0;
}





















