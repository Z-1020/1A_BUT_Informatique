#include <stdio.h>
#include <math.h>

int solve2d( double a, double b, double c, double *x1, double *x2){
	double delta = b*b-4*a*c;
	if(delta <0){
		return 0;
	}
	else if(delta==0){
		*x1=-b/2*a;
		return 1;
	}
	else{
		*x1=(-b-sqrt(delta))/2*a;
		*x2=(-b+sqrt(delta))/2*a;
		return 2;
	}
}

int main(){
	double a,b,c,x1,x2;
	printf("entrez les valeurs\n");
	scanf("%lf", &a);
	scanf("%lf", &b);
	scanf("%lf", &c);
	int resultat = solve2d(a,b,c,&x1,&x2);
	printf("%d\n", resultat);
	printf("%f, %f\n", x1,x2);
}
