#include <stdio.h>
#include <stdlib.h>
#include "ppm.h"

/**
 * affiche une erreur (sur stderr) et termine le programme.
 */
void erreur (char *s)
{
  fprintf(stderr, "erreur: %s\n",s);
  fprintf(stderr,"arrêt du programme\n");
  exit(1);
}

/**
 * ouvre le fichier dont le nom est en paramètre et crée une image correspondante
 * @return la struct image correspondant au fichier
 **/
struct image lire_image(char nom[]){

  FILE *f;
  struct image im;

  if ((f = fopen(nom,"r")) == NULL){
    fprintf(stderr, "Pb ouverture fichier %s\n", nom);
    exit(1);
  }

  char ligne[128];
  // on commence forcement par P3
  if ( (fgets(ligne, 70, f) == NULL)  || ( ligne[0]!='P' && ligne[1]!='3' && ligne[2]!='\n')){
    erreur("Pb lecture P2\n");
  }

  // commentaires
  // on ne considere que les fichiers avec 1 seule ligne de commentaires
  if (fgets(ligne, 128, f) == NULL){
    erreur("lecture commentaires");
  }

  fscanf(f, "%d", &(im.nb_col));
  fscanf(f, "%d", &(im.nb_lig));
  fscanf(f, "%d", &(im.nb_niv));

  printf("Lecture de %s , dimensions détectées : %d %d \n",nom, im.nb_col, im.nb_lig);

  if ((im.contenu=malloc(im.nb_col*im.nb_lig*sizeof(struct pixel )))==NULL)
    erreur("Problème allocation mémoire\n");

  for(int i=0; i< im.nb_col * im.nb_lig; i++){
    int rouge, vert, bleu;

    fscanf(f,"%d %d %d ",&rouge, &vert, &bleu);
    im.contenu[i].rouge = rouge;
    im.contenu[i].vert = vert;
    im.contenu[i].bleu = bleu;
  }
  fclose(f);
  return im;
}



void ecrire_image(struct image im, char nom[]){
  FILE *f;
  if ((f=fopen(nom,"w"))==NULL)
    erreur("Pb ouverture fichier \n");

  fprintf(f,"P3\n");
  fprintf(f,"#\n");

  fprintf(f,"%d ", im.nb_col);
  fprintf(f,"%d\n", im.nb_lig);
  fprintf(f,"%d\n", im.nb_niv);

  for(int i=0; i< im.nb_col * im.nb_lig; i++){
    fprintf(f,"%d %d %d\n", im.contenu[i].rouge, im.contenu[i].vert, im.contenu[i].bleu);
  }
  fclose(f);
}



struct pixel get_pixel(struct image img, int ligne, int col){
  if(ligne > img.nb_lig || col > img.nb_col)
    erreur("tentative de lecture de pixel en dehors de l'image");
  return img.contenu[ligne*img.nb_col+col];
}

void put_pixel(struct image * p_img, struct pixel pix, int ligne, int col){
  if(ligne > p_img->nb_lig || col > p_img->nb_col)
    erreur("tentative d'écriture de pixel en dehors de l'image");
  p_img->contenu[ligne*p_img->nb_col+col] = pix;
}

struct image creer_image_vide(int nb_lignes, int nb_colonnes, int nb_niveaux){
  if (nb_niveaux>65536)
    erreur ("nombre de niveaux par pixel trop élévé");

  struct image im;
  im.nb_lig = nb_lignes;
  im.nb_col = nb_colonnes;
  im.nb_niv = nb_niveaux;
  if ((im.contenu = malloc(im.nb_col * im.nb_lig * sizeof(struct pixel ))) == NULL)
    erreur("Pb  allocation mémoire\n");
  return im;
}

/**
 * libère la mémoire réservée lors de la création de l'image
 **/
void detruire_image(struct image * p_img){
  free(p_img->contenu);
}
