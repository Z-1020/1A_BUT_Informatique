#include <stdio.h>

//1
void carre(int n){
	for(int i=0; i<n; i++){
		for(int j =0; j<n; j++){
			printf("*");
		}
		printf("\n");
	}
}

//2
void triangle(int n){
	for(int i=1; i<n; i++){
		for(int j=1; j<=i;j++){
			printf("*");
		}
		printf("\n");
	}
}
//3
void triangle_bas(int n){
	for(int i=0; i<n; i++){
		for(int j=n; j>i;j--){
			printf("*");
		}
		printf("\n");
	}
}
int main(){
	carre(10);
	return 0;
}
