#include <stdio.h>
#include <math.h>
//1
void damier(int lig, int col){
	for( int i=0; i<lig; i++){
		if(i%2==0){
			for(int j=0; j<col; j=j+1){
				if(j%2==0){
					printf("#");
				}
				else{
					printf(" ");
				}	
			}
		}
		else{		
			for(int j=0; j<col; j=j+1){
				if(j%2==0){
					printf(" ");
				}
				else{
					printf("#");
				}	
			}
		}
		printf("\n");
	}
}
//2
void damier_cadre(int lig, int col){
	printf("+");
	for(int k=0; k<col; k++){
		printf("-");
	}
	printf("+\n");
	for( int i=0; i<lig; i++){
		printf("|");
		if(i%2==0){
			for(int j=0; j<col; j=j+1){
				if(j%2==0){
					printf("#");
				}
				else{
					printf(" ");
				}	
			}
		}
		else{		
			for(int j=0; j<col; j=j+1){
				if(j%2==0){
					printf(" ");
				}
				else{
					printf("#");
				}	
			}
		}
		printf("|\n");
	}
	printf("+");
	for(int k=0; k<col; k++){
		printf("-");
	}
	printf("+\n");
}



int main(){
	damier_cadre(1,20);
	return 0;
}
