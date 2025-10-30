#include <stdio.h>
#include <stdlib.h>
#include "ppm.h"

void negatif(struct image *img){
  for(int l = 0; l < img->nb_lig; l++){
    for(int c = 0; c < img->nb_col; c++){
      struct pixel pix = get_pixel(*img, l, c);
      pix.rouge = img->nb_niv - pix.rouge;
      pix.vert = img->nb_niv - pix.vert;
      pix.bleu = img->nb_niv - pix.bleu;
      put_pixel(img, pix, l, c);
    }
  }
}

int main(){
  struct image img;
  img = lire_image("FleurRVB.ppm");
  negatif(& img);
  ecrire_image(img, "negatif.ppm");
  detruire_image(& img);
  return 0;
}
