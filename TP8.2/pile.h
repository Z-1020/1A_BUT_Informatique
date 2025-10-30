
// les booleans

typedef int bool;

#define true 1
#define false 0

#define MAX_PILE 1024

// notre pile de caractères est définie par
// - un tableau
// - un niveau :
//        0 : pile vide
//        2 : il y a deux éléments dans la pile pile[0] et pile[1]

typedef struct {
    char pile[MAX_PILE];
    int niveau;
} pile_s;

// initisalisation d'une pile vide
void init(pile_s*);

// teste si une pile est vide
bool est_vide(pile_s);

// met le caractere c dans la pile
void empile(pile_s*, char c);

// depile et retourne le sommet de la pile
char depile(pile_s*);

// affiche la pile (pour le débogage)
void affiche(pile_s);








