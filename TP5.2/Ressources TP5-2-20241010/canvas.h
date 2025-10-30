#ifndef __CANVAS__
#define __CANVAS__

typedef struct canvas_t*  canvas;

/**
 * crée une surface de dessin de dimension donnée. 
 * Le canvas est toujours carré.
 * @param la dimension du dessin
 * @return la surface de dessin (canvas)
 */
canvas create_canvas(unsigned int dim);

/** 
 * Positionne le caractère caractere à la position indiquée par la ligne et la colonne
 * 
 * En cas de paramètres invalides (ligne ou colonne), 
 * affiche un message d'erreur et ne fait rien.
 *
 * @param c le canvas dans lequel positionner le caractère
 * @param col numéro de la colonne (entre 0 et la taille-1 du canvas)
 * @param lig numéro de la ligne (entre 0 et la taille-1 du canvas)
 * @param caractere le caractere à positionner (ascii simple, pas d'UTF8)
 */
void set(canvas c, int col, int lig, char caractere);

/** 
 * Retourne le caractère en position (col,lig) dans le canvas.
 * 
 * En cas de paramètres invalides (ligne ou colonne), affiche un message d'erreur
 * et retourne 0.
 * 
 * @param c le canvas dans lequel chercher le caractère
 * @param col numéro de la colonne (entre 0 et la taille-1 du canvas)
 * @param lig numéro de la ligne (entre 0 et la taille-1 du canvas)
 * @return le caractere de la case correspondante
 * 
 */
char get(canvas c, int col,  int lig);

/**
 * Retourne la taille du côté du canvas en paramètre
 * @param c le canvas dont la taille doit être récupérée
 * @return la taille du côté de ce canvas (carré)
 */
int get_size(canvas c);

/**
 * Affiche le canvas en paramètre sur la sortie standard (terminal)
 * @param c le canvas à afficher
 */
void plot(canvas c);

#endif
