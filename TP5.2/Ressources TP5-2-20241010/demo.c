#include "canvas.h"
#include "canvas.h"

 void demo(){

     // creation d'un canvas. Chaque case du canvas alloué
     // contient des espaces ' '
    canvas c=create_canvas(7);

    // Quelques cases du canvas sont affectées avec des caractères
    set(c, 0, 0,'*');
    set(c, 1, 1,'*');
    set(c, 2, 2,'*');
    set(c, 3, 3,'V');
    set(c, 6, 0,'*');
    set(c, 5, 1,'*');
    set(c, 4, 2,'*');
    
    // le canvas est affiché à l'écran
    plot(c);
}

int main()
{
    demo();
}
