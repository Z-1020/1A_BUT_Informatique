#include <stdio.h>
//1
int compter_multiples(int nb, int mult){
	for( int i = 1; i<=nb; i+=1){
		if (i%mult==0){
			return i;
			printf("%d ", i);
		}
	}
	printf( "\n");
	return 0;
} 


//2
 void test_compter_multiples(){
 	if(compter_multiples(30,3) !=10){
 		printf( "fonctionne" );
 	}
 	else
 		printf("ne fonctionne pas");
 	printf("\n");
 } 



//3




int main(){
	test_compter_multiples();
	return 0;
}

