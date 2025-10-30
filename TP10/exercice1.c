#include <stdio.h>
#include <stdlib.h>
#include "ppm.h"

void filtre_rouge(struct image *img){
  for(int l = 0; l < img->nb_lig; l++){
    for(int c = 0; c < img->nb_col; c++){
      struct pixel pix = get_pixel(*img, l, c);
      pix.rouge = pix.rouge;
      pix.vert = 0;
      pix.bleu = 0;
      put_pixel(img, pix, l, c);
    }
  }
}
void niv_gris(struct image *img){
    int lum = 0;
  for(int l = 0; l < img->nb_lig; l++){
    for(int c = 0; c < img->nb_col; c++){
      struct pixel pix = get_pixel(*img, l, c);
      lum = 0.3*pix.rouge+0.59*pix.vert+0.11*pix.bleu;  
      pix.rouge = lum;
      pix.vert = lum;
      pix.bleu = lum;
      put_pixel(img, pix, l, c);
    }
  }
}

void rectangle(struct image *img, int l1, int c1, int l2, int c2){
    for(int l=l1; l<l2; l++){
        for(int c=c1; c<c2; c++){
            struct pixel pix = get_pixel(*img, l, c);
            pix.rouge = 255;
            pix.vert = 255;
            pix.bleu = 255;
            put_pixel(img, pix, l, c);
        }
    }
}
void cadre(struct image *img, int l1, int c1, int l2, int c2){
    for(int l=l1; l<l2; l++){
        for(int c=c1; c<c2; c++){
            struct pixel pix = get_pixel(*img, l, c);
            pix.rouge = 255;
            pix.vert = 255;
            pix.bleu = 255;
            put_pixel(img, pix, l, c);
            if(l==l1 || c==c1 ){
                pix.rouge = 0;
                pix.vert = 0;
                pix.bleu = 0;
                put_pixel(img, pix, l, c);
            }
            else if(l==l2-1 || c==c2-1){
                pix.rouge = 0;
                pix.vert = 0;
                pix.bleu = 0;
                put_pixel(img, pix, l, c);
            }
        }
    }
}
void cadre_epais(struct image *img, int l1, int c1, int l2, int c2, int epaisseur){
    for(int l=l1; l<l2; l++){
        for(int c=c1; c<c2; c++){
            for(int e=0; e<epaisseur; e++){
                struct pixel pix = get_pixel(*img, l, c);
                if((l<l1-epaisseur || l>l1+epaisseur) && (c<c1-epaisseur || c>c1+epaisseur)){
                    pix.rouge = 255;
                    pix.vert = 255;
                    pix.bleu = 255;
                    put_pixel(img, pix, l, c);
                }
                else if((l<l2-epaisseur || l>l2+epaisseur )&& (c<c2-epaisseur || c>c2+epaisseur )){
                    pix.rouge = 255;
                    pix.vert = 255;
                    pix.bleu = 255;
                    put_pixel(img, pix, l, c);
                }
            }
        }
    }
}


int main(){
  struct image img;
  img = lire_image("FleurRVB.ppm");
  cadre_epais(& img, 10, 100, 50, 300, 100);
  ecrire_image(img, "cadre_epais.ppm");
  detruire_image(& img);
  return 0;
}
