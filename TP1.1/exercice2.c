#include <stdio.h>
int verification( int entier ){
	if( entier%2 == 0 && entier>0 && entier%5 !=0 && (entier/10 >=1 && entier/10<10)){
		return 1;
	}
	else
		return 0;
}

void test_verif(){
	if (verification(20) ==1){
	printf("fonctionne\n");
	}
	else
	printf("ne fonctionne pas\n");
}




int main(void){
	test_verif();
	return 0;
}
 
