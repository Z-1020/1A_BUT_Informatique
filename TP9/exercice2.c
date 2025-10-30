#include <stdio.h>

int selection(int tab[], int debut, int fin){
    int i_min = debut;
    for(int i = debut; i<=fin; i++){
        if(tab[i_min] >= tab[i]){
            i_min = i;
        }
    }
    return i_min;
}
void tri_selection(int tab[], int n){
    int i_min;
    int temp;
    for(int i=0; i<n; i++){
        i_min=selection(tab, i, n);
        temp = tab[i];
        tab[i] = tab[i_min];
        tab[i_min] = temp;
        printf("%d ", tab[i]);
    }
}


int main(){
    int tab[]={2,7,1,8,3,4};
    tri_selection(tab, 6);
}

