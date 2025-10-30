#include "pile.h"
#include "stdio.h"
#include "stdlib.h"

void init(pile_s *p){
    p->niveau=0;
}

bool est_vide(pile_s p){
    return (p.niveau==0);
}

void empile(pile_s *p, char c){
    if (p->niveau==MAX_PILE) {
	fprintf(stderr,"Pile pleine\n");
	exit(1);
    }
    p->pile[p->niveau]=c;
    p->niveau++;
}

char depile(pile_s *p){
    p->niveau--;
    return p->pile[p->niveau];
}

void affiche(pile_s p){
    if (est_vide(p)) printf("Pile vide");
    else {
	printf("Pile : ");
	for(int i=0;i<p.niveau;i++)
	    printf("%c ",p.pile[i]);
    }
    printf("\n");
}
