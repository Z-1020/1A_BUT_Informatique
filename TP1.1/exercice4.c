 #include <stdio.h>
 double difference( double a, double b){
	if(a<b){
		return b-a;
	}
	else{
		return a-b;
	}
}
void test_difference(){
	if(difference(6,4) > 0){
	printf("fonctionne\n");
	}
	else{
	printf("ne fonctionne pas\n");
	}
}

int main(void){
	test_difference();
	return 0;
}
