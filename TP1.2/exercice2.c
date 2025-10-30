#include <stdio.h>
//1
void factorielle( int n){
	int fact = 1;
	for(int i =1; i <=n ; i+=1){
		fact = fact*i;
	}
	printf("%d " ,fact);
	printf("\n");
}

//2
void somme_impairs( int n){
	int somme = 0;
	for(int i= 1; i<n; i+=1){
		if(i%2!=0){
		somme = somme +i;
		}
	}
	printf("%d", somme);
}
			



int main(){
	somme_impairs(5);
	return 0;
}			
