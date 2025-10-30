#include <stdio.h>

//exercice2

//1

struct horaire{
	int heure;
	int minute;
	int seconde;
};
//2

void affiche_date(struct horaire h1){
	printf("%dh %dm %ds\n", h1.heure, h1.minute, h1.seconde);
}

//3

struct hor{
	int seconde;
	int minute;
	int heure;
};
	
void seconde_vers_horaire(int sjournee, struct hor p_hor){
	p_hor.heure=sjournee/3600;
	p_hor.minute=(sjournee/60-p_hor.heure*60);
	p_hor.seconde= sjournee - p_hor.minute*60 -p_hor.heure*3600;
	printf("%dh %dm %ds\n", p_hor.heure, p_hor.minute, p_hor.seconde);
}

//4

void saisir_horaire(){
	int minute;
	int seconde;
	int heure;
	printf("entrez les heures");
	scanf("%d", &heure);
	printf("entrez les minutes");
	scanf("%d", &minute);
	printf("entrez les secondes");
	scanf("%d", &seconde);
	struct horaire h2={heure, minute, seconde,};
	printf("%dh, %dm, %ds\n", h2.heure, h2.minute, h2.seconde);
}

//5

void une_seconde_plus_tard(struct horaire h3){
	h3.seconde=h3.seconde+1;
	if(h3.seconde==60){
		h3.seconde=0;
		h3.minute=h3.minute+1;
		if(h3.minute==60){
			h3.minute=0;
			h3.heure=h3.heure+1;
			if(h3.heure>23){
				h3.heure=h3.heure-24;
			}
		}
	}
	printf("%dh %dm %ds\n", h3.heure, h3.minute, h3.seconde);
}
//6

void une_seconde_moins_tard(struct horaire h3){
	h3.seconde=h3.seconde-1;
	if(h3.seconde==-1){
		h3.seconde=59;
		h3.minute=h3.minute-1;
		if(h3.minute==-1){
			h3.minute=59;
			h3.heure=h3.heure-1;
			if(h3.heure<0){
				h3.heure=h3.heure+24;
			}
		}
	}
	printf("%dh %dm %ds\n", h3.heure, h3.minute, h3.seconde);
}

int main(){
	struct horaire h3={00,00,00};
	une_seconde_moins_tard(h3);
	return 0;
}
