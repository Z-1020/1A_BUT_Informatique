#include <stdio.h>
#include <stdlib.h>
#include "ppm.h"

void rectangle_gris(struct image *img){
    int c1=5*(img->nb_col)/6;
    int l1=0;
    for(int l=l1; l<30; l++){
        for(int c=(img->nb_col)/6; c<c1; c++){
            struct pixel pix = get_pixel(*img, l, c);
            pix.rouge = 127;
            pix.vert = 127;
            pix.bleu = 127;
            put_pixel(img, pix, l, c);
        }
    }
}
void degrade(struct image *img){
    img->nb_col=500;
    img ->nb_lig=300;
    int degrade=0;
        for(int l=0; l<img->nb_lig; l++){
            degrade++;
            for(int c=0; c<img->nb_col; c++){
                struct pixel pix = get_pixel(*img, l, c); 
                pix.rouge = degrade;
                pix.vert = degrade;
                pix.bleu = degrade;
                put_pixel(img, pix, l, c);
        }
    }
    
}  
void eclaircir_ligne(struct image *img, int ligne){
    img->nb_col=500;
    img ->nb_lig=300;
    for(int l=0; l<img->nb_lig; l++){
        for(int c=0; c<img->nb_col; c++){
            struct pixel pix = get_pixel(*img, l, c);
            pix.rouge = 0;
            pix.vert = 250;
            pix.bleu = 0;
            if(l==ligne && pix.rouge+128<=255 && pix.vert+128<=255 && pix.bleu+128<=255){
                pix.rouge = pix.rouge+128;
                pix.vert = pix.vert+128;
                pix.bleu = pix.bleu+128;
            } 
            else{
                pix.rouge = 0;
                pix.vert = 0;
                pix.bleu = 0;
            }
            put_pixel(img, pix, l, c);
            }
        }
}

void eclaircir_colonne(struct image *img, int colonne){
    img->nb_col=500;
    img ->nb_lig=300;
    for(int l=0; l<img->nb_lig; l++){
        for(int c=0; c<img->nb_col; c++){
            struct pixel pix = get_pixel(*img, l, c);
            pix.rouge = 0;
            pix.vert = 0;
            pix.bleu = 0;
            if(c==colonne && pix.rouge+128<=255 && pix.vert+128<=255 && pix.bleu+128<=255){
                pix.rouge = pix.rouge+128;
                pix.vert = pix.vert+128;
                pix.bleu = pix.bleu+128;
            } 
            else{
                pix.rouge = 0;
                pix.vert = 0;
                pix.bleu = 0;
            }
            put_pixel(img, pix, l, c);
            }
        }
}

void ligne_colonne(struct image *img){
    img->nb_col=590;
    img ->nb_lig=360;
    int l2=10;
    int c2=10;
    for(int l=0; l<img->nb_lig; l++){
        for(int c=0; c<img->nb_col; c++){
            for(int l1=0; l1<l2; l1++){
                for(int c1=0; c1<c2; c1++){
                    struct pixel pix = get_pixel(*img, l, c);
                    pix.rouge = 0;
                    pix.vert = 0;
                    pix.bleu = 0;
                    if((c%50==0 || l%50==0) && pix.rouge+128<=255 && pix.vert+128<=255 && pix.bleu+128<=255){
                        pix.rouge = pix.rouge+128;
                        pix.vert = pix.vert+128;
                        pix.bleu = pix.bleu+128;
                        put_pixel(img, pix, l, c);
                    } 
                    else{
                        pix.rouge = 0;
                        pix.vert = 0;
                        pix.bleu = 0;
                        put_pixel(img, pix, l, c);
                    }
                }
            }
        }
    }
}


	
	
	

void ligne_de_carres(struct image *img){
	int ep=50;
	img->nb_col=500;
    img ->nb_lig=300;
    for(int l=0; l<img->nb_lig; l++){
        for(int c=0; c<img->nb_col; c++){
            for(int l1=0; l1<l1+ep; l1++){
                for(int c1=0; c1<c1+ep; c1++){
                    struct pixel pix = get_pixel(*img, l, c);
                    pix.rouge = 0;
                    pix.vert = 0;
                    pix.bleu = 0;
                    if(((c%50==0 && c-ep<c)){
                        pix.rouge = 255;
                        pix.vert = 255;
                        pix.bleu = 255;
                        put_pixel(img, pix, l, c);
                    } 
                    else{
                        pix.rouge = 0;
                        pix.vert = 0;
                        pix.bleu = 0;
                        put_pixel(img, pix, l, c);
                    }
                }
            }
        }
    }
}

int main(){
  struct image img;
  img = lire_image("FleurRVB.ppm");
  ligne_de_carres(& img);
  ecrire_image(img, "illusion3.ppm");
  detruire_image(& img);
  return 0;
}
