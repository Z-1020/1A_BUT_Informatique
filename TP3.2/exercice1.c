#include <stdio.h>
#include <math.h>
//1
int est_triplet( int a, int b,int c){
	 if(a*a+b*b == c*c){
	 	return 1;
	 	printf("\n");
	 }
	 else{
	 	return 0;
	 	printf("\n");
	 }
}
//2
void test_triplet(){
	if ((est_triplet(3,4,5) ==1) && (est_triplet(63,16,65)==1) && (est_triplet(36,77,84) == 0) ){
		printf("OK, test de la fonction réussi\n");
	}
	else{
		printf("la reponse est erronee\n");
	}
}

//3
//void f_triplet( int n){
	//int a=0;
	//int b=0;
	//int c=0;
	//for(a=0; a<n; a++){
		//for(b=0; b<n; b++){
			//for(c=0; c<n; c++){
				//int triplet = est_triplet(a, b, c);
				//printf("%d");
			//}
		//}
	//}
//}


void affiche_triplet( int n){
	int a =0;
	int b =0;
	int c =0;
	for( a=0; a<n; a++){
		for( b=0; b<n; b++){
			for(c=0; c<n; c++){
				if(est_triplet(a,b,c)==1 && (a!=0 && b!=0 && c!=0) && (a<b && a<c && b<c)){
					printf("(%d, %d, %d)\n",a,b,c);
				}
			}
		}
	}
} 
		
//4
void nb_triplet( int n){
	int a =1;
	int b =1;
	int c =1;
	for( a=1; a<n; a++){
		for( b=1; b<n; b++){
			for(c=1; c<n; c++){
				if(est_triplet(a,b,c)==1 && (a!=0 && b!=0 && c!=0) && (a<b && a<c && b<c)){
					printf("(%d, %d, %d)\n",a,b,c);
				}
			}
		}
	}
} 

int main(){
	nb_triplet(100);
	printf("\n");
	return 0;
}
