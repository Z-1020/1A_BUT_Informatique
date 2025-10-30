#include <stdio.h>

//exercice 1
//1
int carre(int x){
	return x*x;
}

//2
int pair(int x){
	if(x%2==0){
		return x;
	}
	else{
		return x-1;
	}
}

//3
void test_pair(){
	int x=-2;
	if(pair(x)==x || pair(x)==x-1){
		printf("la fonction est valide\n");
	}
	else{
		printf("la fonction n'est pas valide\n");
	}
}
//4
double difference( double a, double b){
	if(a-b>0){
		return a-b;
	}
	else if(b-a>0){
		return b-a;
	}
	else {
		return 0;
	}
}
//5
void test_difference(){
	double a=2;
	double b=3;
	if((difference( a, b)== a-b && difference(a,b)>0) || (difference(a,b)== b-a && difference(a,b)>0)){
		printf("fonctionne\n");
	}
	else{
		printf("ne fonctionne pas\n");
	}
}

// exercice 2

//1
int verification( int entier){
	if( entier%2 == 0 && entier>0 && entier/10>0 && entier/100==0 && entier%5 !=0){
		return 1;
	}
	else{
		return 0;
	}
}	
	
int main(){
	printf("%d\n", verification (10));
	return 0;
} 

