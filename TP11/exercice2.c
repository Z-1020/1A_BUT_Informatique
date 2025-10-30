#include <stdio.h>
#include <stdlib.h>
#include "ppm.h"

void ouvrir_placard(struct image *img){
  for(int l = 0; l < img->nb_lig; l++){
    for(int c = 0; c < img->nb_col; c++){
      struct pixel pix = get_pixel(*img, l, c);
      pix.rouge = pix.rouge;
      pix.vert = pix.vert;
      pix.bleu = pix.bleu;
      put_pixel(img, pix, l, c);
      for(int c_dec=71; c_dec<131; c_dec--){
		pix.rouge = pix.rouge;
		pix.vert = pix.vert;
		pix.bleu = pix.bleu;
		put_pixel(img, pix, l, c);
	}
    }
  }
}

int main(){
  struct image img;
  img = lire_image("placard.ppm");
  ouvrir_placard(& img);
  ecrire_image(img, "placard_ouvert.ppm");
  detruire_image(& img);
  return 0;
}
