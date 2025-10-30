#include "canvas.h"
#include "canvas.h"

 /*void demo(){

     // creation d'un canvas. Chaque case du canvas alloué
     // contient des espaces ' '
    canvas c=create_canvas(8);

    // Quelques cases du canvas sont affectées avec des caractères
    for (int i=0; i<=7; i++){
    	for(int j=0; j<=7; j++){
    set(c, 0, j,'X');
    set(c, 1, j,'X');
    set(c, 2, ,'X');
    set(c, 3, i,'X');
    set(c, 6, i,'X');
    set(c, 5, i,'X');
    set(c, 4, i,'X');
    set(c, 7, i,'X');
    }
    
    // le canvas est affiché à l'écran
    plot(c);
}
*/
void damier64(){
	canvas c=create_canvas(64);
	for(int ligne =0; ligne<=64; ligne++){
		for(int colone=0; colone<=64; colone++){
			if(ligne%2==0 && colone%2==0){
				set(c, ligne, colone, 'X');
			}
			else if(ligne%2==0 && colone%2!=0){
				set(c, ligne, colone, ' ');
			}
			else if(ligne%2!=0 && colone%2==0){
				set(c, ligne, colone, ' ');
			}
			else if(ligne%2!=0 && colone%2!=0){
				set(c, ligne, colone, 'X');
			}
		}
	}
	plot(c);
}   
 void diagonale(int n){
	canvas c=create_canvas(n+1);
	for(int i=0; i<=n+1; i++){
		set(c, i, i, 'X');
	}
	plot(c);
}

void deuxieme_diagonale(int n){
	canvas c=create_canvas(n+1);
	for(int i=0; i<=n+1; i++){
		for(int j=n+1; j>=0; j--){
			if(j+i==n){
			set(c, i, j, 'X');
			}
		}
	}
	plot(c);
}
//6

void un_carre(canvas c, int cote, int column, int line){
	for(int i=column; i<=cote+1; i++){
		for(int j=line; j<=cote+1; j++){
			if((i==column || i>=cote+1) || (j==line || j>=cote+1)){
				set(c, i, j, 'X');
			}
		}
	}
}

void test_carre(){
	canvas c=create_canvas(15);
	 un_carre(c, 10, 4, 2);
	 plot(c);
}	
//7 

void carre_dans_un_carre(canvas c, int cote, int column, int line){
	for(int carre=0; carre<=16; carre++){ 
		for(int i=column; i<=cote+1; i++){
			i=i-2;
			for(int j=line; j<=cote+1; j++){
				if((i==column || i>=cote+1) || (j==line || j>=cote+1)){
					set(c, i, j, 'X');
				}
			}
		}
	}
}
void carre_dans_un_carre(){
	canvas c=create_canvas(16);
	int i;
	int j;
	int k;
	 for(i=14; i>0; i--);
	 	for( j=0; j<=14; j=j+2){
	 		for(k=0; k<=14; k=k+2){
	 			un_carre(c, i, j, k);
	 		}
	 	}
	 }  
}






int main(){
   	carre_dans_un_carre();
}
