#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define DIML 3
#define DIMC 3


void generer(int tab[DIMC][DIML]){
    int nb=0;
    for(int i=0; i<DIMC; i++){
        for(int j=0; j<DIML; j++){
            nb=rand()%100;
            if(nb%2==0){
                tab[i][j]=' ';
            }
            else{
                tab[i][j]='o';
            }
        }
    }
}

void afficher(){
    int tab[DIMC][DIML];
    generer(tab);
    for(int i=0; i<DIMC; i++){
        for(int j=0; j<DIML; j++){
            printf("%c", tab[i][j]);
        }
        printf("\n");
    }
    
}
/*
 int nb_vivantes(){
    int compteur_vivant=0;
    int compteur_mort=0;
    int tab[DIMC][DIML];
    generer(tab);
    afficher();
    for(int i=0; i<DIMC; i++){
        for(int j=0; j<DIML; j++){
            if(tab[i][j]=='o'){
                if((tab[i-1][j-1]=='o' && tab[i][j-1]=='o' && tab[i+1][j-1]=='o')|| (tab[i-1][j]=='o' && tab[i][j]=='o' && tab[i+1][j]=='o')|| (tab[i-1][j+1]=='o' && tab[i][j+1]=='o' && tab[i+1][j+1]=='o')){
                compteur_vivant++;
                }
                else if(tab[i-1][j-1]=='o' && tab[i-1][j]=='o' && tab[i-1][j+1]=='o'){
                compteur_vivant++;
                }
                else if(tab[i][j-1]=='o' && tab[i][j]=='o' && tab[i][j+1]=='o'){
                compteur_vivant++;
                }
                else if(tab[i+1][j-1]=='o' && tab[i+1][j]=='o' && tab[i+1][j+1]=='o'){
                compteur_vivant++;
                }
                else if(tab[i-1][j-1]=='o' && tab[i][j-1]=='o' && tab[i-1][j]=='o'){
                compteur_vivant++;
                }
                else if(tab[i][j-1]=='o' && tab[i+1][j-1]=='o' && tab[i-1][j]=='o'){
                compteur_vivant++;
                }
                else if(tab[i][j-1]=='o' && tab[i+1][j-1]=='o' && tab[i-1][j]=='o'){
                compteur_vivant++;
                }
            }
        }
    }
    return compteur_vivant;

}
*/
int nb_vivantes(){
    int compteur_vivant=0;
    int compteur_mort=0;
    int compteur_intermédiaire=0;
    int tab[DIMC][DIML];
    generer(tab);
    afficher();
    for(int i=0; i<DIMC; i++){
        for(int j=0; j<DIML; j++){
                for(int l=i-1; l<i+1; l++){
                    for(int c=j-1; c<j+1; c++){
                            compteur_intermédiaire++;
                        }

                    }
                }

        }
        return compteur_intermédiaire;
}

int main(){
    srand(time(NULL));
    int tab[DIMC][DIML];
    printf("%d", nb_vivantes());
}