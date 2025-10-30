

#include "pile.h"
#include <stdio.h>

int main()
{
    pile_s p;

    init(&p);
    affiche(p);

    empile(&p,'j');
    affiche(p);
    empile(&p,'e');
    affiche(p);
    empile(&p,'a');
    affiche(p);
    empile(&p,'n');
    affiche(p);




    printf("depile %c \n",depile(&p));
    affiche(p);
    printf("depile %c \n",depile(&p));
    affiche(p);
    printf("depile %c \n",depile(&p));
    affiche(p);
    printf("depile %c \n",depile(&p));
    affiche(p);

    char c='A';
    for (int i=0;i<20;i++){
	printf("%2d : empile %c\n",i,c+i);
	empile(&p,c+i);
    }

}
