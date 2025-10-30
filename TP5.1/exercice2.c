#include <stdio.h>

//1
struct date{
	int jour;
	int mois;
	int annee;
};
//2

struct date cree_date(int jour, int mois, int annee){
	struct date d={jour,mois,annee};
	return d;
}


//3
void affiche_date(struct date d){
	printf("%02d/%02d/%4d", d.jour, d.mois, d.annee);
}


	
struct date cree_date1(int jour, int mois, int annee){
	struct date d1={jour,mois,annee};
	return d1;
}
struct date cree_date2(int jour, int mois, int annee){
	struct date d2={jour,mois,annee};
	return d2;
}
//4	
int date_identique( struct date d1, struct date d2){
	if(d1.jour==d2.jour && d1.mois==d2.mois && d1.annee==d2.annee){
		return 1;
	}
	else{
		return 0;
	}
}

//5
int bisextile(int annee){
	if((annee%4==0 && annee%100!=0) || annee%400==0){
		return 1;
	}
	else{
		return 0;
	}
}
int nombre_jour_mois(struct date d){
	if(bisextile(d.annee)==1){
		if(d.mois==2){
			return 29;
		}
		else if(d.mois%2!=0){
			return 30;
		}
		else if(d.mois%2==0){
			return 31;
		}
	}
	else{
		if(d.mois%2!=0){
			return 30;
		}
		else if(d.mois%2==0){
			return 31;
		}
	}
}
	
int valide	
	
int main(){
	struct date d={6,2020};
	printf("%d\n", nombre_jour_mois(d));
}
