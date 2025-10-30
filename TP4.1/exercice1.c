#include <stdio.h>

void echange(int* a, int* b){
	int tmp;
	tmp= *a;
	*a= *b;
	*b= tmp;
}

int solve2d( double a, double b, double c, double *x1, double *x2){
	double delta = b*b-4*a*c;
	if(delta <0){
		return 0;
	}
	else if(delta==0){
		*x1=-b/2a;
		return 1;
	}
	else{
		*x1=(-b-sqrt(delta))/2a;
		*x2=(-b+sqrt(delta))/2a;
		return 2;
	}
}



int main(){
	int a,b;
	a=16; b=4;
	printf("avant echange a=%d b=%d\n", a,b);
	echange(&a,&b);
	printf("apres echange a=%d b=%d\n", a,b);
}
