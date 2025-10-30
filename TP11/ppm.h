#ifndef __PGMPPM_PPM
#define __PGMPPM_PPM

struct pixel{
    int rouge;
    int vert;
    int bleu;
};

struct image {
    int nb_lig; /*< nombre de lignes de l'image*/
    int nb_col;  /*< nombre de colonnes de l'image*/
    int nb_niv; /*< nombre de niveaux par pixel (qualité des couleurs)*/
    struct pixel *contenu; /*< un pointeur sur un tableau de pixels*/
};

/**
 * @brief Ouvre le fichier du nom indiqué en mémoire, le stocke dans la structure de donnée adaptée.
 * @param nom nom du fichier à ouvrir
 * @return une struct imagePPM contenant l'image
 **/
struct image lire_image(char nom[]);

/**
 * @brief récupère le pixel à la position donnée.
 * @param img l'image à lire
 * @param ligne numéro de ligne à consulter
 * @param col numéro de colonne à consulter
 * @return le pixel consulté
 */
struct pixel get_pixel(struct image img, int ligne, int col);

/**
 * @brief affecte le pixel fourni à la position donnée.
 *
 * On notera que l'on n'a pas besoin de passer l'adresse de la structure 
 * car le contenu dans la struct image est en fait l'adresse d'un tableau.
 *
 * @param p_img l'adresse de l'image à modifier
 * @param pix le pixel à positionner
 * @param ligne numéro de ligne à consulter
 * @param col numéro de colonne à consulter
 */
void put_pixel(struct image * p_img, struct pixel pix, int ligne, int col);

/**
 * @brief enregistre la struct image en paramètre dans le fichier nommé *nom*
 * Si un tel fichier existe déjà, il est écrasé.
 * @param imagePPM une image dans la structure ci-dessus
 * @param nom le nom du ficher dans lequel l'image doit être sauvegardée.
 **/
void ecrire_image(struct image img, char nom[]);

/**
 * @brief crée une image vide
 * @param nb_lignes nombre de lignes de l'image créée (e.g. 384)
 * @param nb_colonnes nombre de colonne de l'image créée (e.g. 512)
 * @param nb_niveaux valeur maximum utilisée pour les nombre de couleur (typiquement 255)
 **/
struct image creer_image_vide(int nb_lignes, int nb_colonnes, int nb_niveaux);

/**
 * @brief Libère la mémoire réservée à la création de l'image
 * @param p_img l'adresse de l'image à détruire
 **/
void detruire_image(struct image * p_img);

#endif
