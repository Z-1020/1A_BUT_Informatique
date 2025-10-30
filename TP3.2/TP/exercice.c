#include <stdio.h>

double vers_farenheit(double temp){
	return temp*1.8 +32;
}
	
void test_vers_farenheit(){
	double temp1=0*1.8+32;
	double temp2=37*1.8+32;
	if(vers_farenheit(0)==temp1 && vers_farenheit(37)==temp2){
		printf("fonctionne\n");
	}
	else{
		printf("ne fonctionne pas\n");
	}
}

//2
int projette(int min, int x, int max){
	if(min<x && x<max){
		return x;
	}
	else if(min>x && x<max){
		return min;
	}
	else if(max<x && x>min){
		return max;
	}
	else if(max>min && x>max){
		return x;
	}
}

void test_projette(){
	if( projette(2,3,4)==3 || projette(3,2,4)==3 || projette(2,4,3)==3 || projette(4,3,2)==3){
		printf("fonction valide\n");
	}
	else{
		printf("fonction invalide\n");
	}
}
	
int main(){
	printf("%f\n", vers_farenheit(37));
	test_vers_farenheit();
	test_projette();
}
