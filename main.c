/*
    Groupe :
        Brice Ramette TD1
        Zoé Margerie TD1
*/
#include <stdio.h>
#include "board.h"

#define TAILLE_NOM 30

/*
    * Description :
        Convertie le choix de la direction du joueur en code correspondant aux directions (énumérations)
    * Valeur de retour :
        La direction correspondant au choix du joueur
*/
int converti_choix_direction(int direction_choisi){    
    switch(direction_choisi){
        case 1:
            return 5;
            break;
        case 2:
            return 6;
            break;
        case 3:
            return 7;
            break;
        case 4:
            return 3;
            break;
        case 6:
            return 4;
            break;
        case 7:
            return 0;
        case 8:
            return 1;
        case 9:
            return 2;
            break;
        default:
            printf("Choix incorrecte !\n");
            return -1;
    }
}

/*
    * Description :
        Convertie la direction en code correspondant au choix du joueur
    * Valeur de retour : 
        Le choix du joueur correspondant à la direction
*/

int converti_direction_choix(int direction_enum){
    switch(direction_enum){
        case 5:
            return 1;
            break;
        case 6:
            return 2;
            break;
        case 7:
            return 3;
            break;
        case 3:
            return 4;
            break;
        case 4:
            return 6;
            break;
        case 0:
            return 7;
        case 1:
            return 8;
        case 2:
            return 9;
            break;
        default:
            printf("Direction incorrecte !\n");
            return -1;
    }
}

/*
    * Description :
        Convertie le code qui correspond au contenu en caractère
    * Valeur de retour :
        Ce que contient chaque cellule du plateau en caractère
*/
char contient_cellule(int cellule){
    switch(cellule){
        case 0:
            return ' ';
            break;
        case 1:
            return 'N';
            break;
        case 2:
            return 'S';
            break;
        case 3:
            return '#';
            break;
        default:
            printf("Cellule non reconnu dans le jeu (fonction contient_cellule)\n");
            return 'E';
    }
}
/*
    * Description :
        Affiche les messages d'erreurs des codes
    * Valeur de retour : 
        Rien
*/
void affiche_message_erreur(int code_retour){
    switch(code_retour){
        case 0:
            printf("La case n'est pas vide.\n");
        case 1:
            printf("Les coordonnées ne sont pas sur le tableau ou cette case est déjà tuée.\n");
            break;
        case 2:
            printf("La case est déjà occupée.\n");
            break;
        case 3:
            printf("L'action ne respecte pas les règles.\n");
        case 4:
            printf("Vous ne pouvez pas aller dans cette direction.\n");
            break;
        default:
            break;
    }
}
/*
    * Description :
        Supprime les directions non jouable par le joueur
    * Valeur de retour :
        Rien
*/
void supprime_valeur_tableau_direction(int tableau_direction[], int direction){
    for(int i=0; i<9; i++){
        if(tableau_direction[i] == direction){
            tableau_direction[i] = 0;
        }
    }
}
/*
    * Description :
        Vérifie que la direction sélectionnée par le joueur est jouable
    * Valeur de retour :
        Un code (d'erreur ou pas)
*/
int verifie_direction(int direction_choisie, int tableau_direction[]){
    for(int i=0; i<9; i++){
        if(direction_choisie == tableau_direction[i]) return 5;
    }
    return 4;
}


/*
    * Description :
        Etablit et affiche les directions jouable par le joueur
    * Valeur de retour :
        Rien
*/

void affiche_choisir_direction(char nom[], int tableau_direction[], board jeu){
    int direction_disponible;
    for(int direction = 0; direction <8; direction++){
        board new_jeu = copy_game(jeu);
        direction_disponible = move_toward(new_jeu, direction);

        if(direction_disponible == 1 || direction_disponible == 2){
            supprime_valeur_tableau_direction(tableau_direction, converti_direction_choix(direction));
        }
    }
    printf("↧↧↧↧ Choisissez votre direction ↧↧↧↧\n");
    char lettre = 'X';
    for(int v = 0; v<9; v++){
        if(v%3 == 0 ){
            printf("\n");
        }
        if(v == 4) printf("%2c", lettre);
        else if(tableau_direction[v] == 0 && v!=4){
            printf("%2c", lettre);
        } else{
            printf("%2d", tableau_direction[v]);
        }
    }
    printf("\n");
}
/*
    * Description :
        Demande la direction au joueur
    * Valeur de retour :
        La direction choisi par le joueur
*/
int demande_direction(int tableau_direction[]){
    int entree_direction;
    int verif_direction;
    do{
        printf("Choissisez la direction que vous souhaitez : ");
        scanf("%d", &entree_direction);
        while(getchar() != '\n');
        verif_direction = verifie_direction(entree_direction, tableau_direction);
        affiche_message_erreur(verif_direction);
    } while( verif_direction != 5);
    return converti_choix_direction(entree_direction);
}
/*
    * Description :
        Demande le nom du joueur et stocke le nom dans un tableau
    * Valeur de retour :
        Rien
*/
void demande_nom(char nom[]){
    int compteur = 0;
    char lettre;
    printf("Rentrez votre nom et faites ENTRER : ");
    do{
        scanf("%c", &lettre);
        nom[compteur] = lettre;
        compteur++;
    } while(lettre != '\n' && compteur+1 < TAILLE_NOM);
    nom[compteur-1] = '\0';
}

/*
    * Description :
        Affiche l'interface de jeu
    * Valeur de retour :
        Ne retourne rien
*/

void afficher_jeu(board jeu){
    cell cellule;
    for(int c = 1; c<NB_COLS+1; c++){
        printf(" %3d ", c);
    }
    printf("\n");

    for(int l=1; l<NB_LINES+1; l++){
        for(int c=1; c<NB_COLS+1; c++){
            printf("─────");
        }
        printf("|\n");
        for(int c=1; c<NB_COLS+1; c++){
            cellule = get_content(jeu, l-1, c-1);
            printf("||");
            printf("%2c ", contient_cellule(cellule));
        }
        printf("| %d\n", l);
    }
    for(int c=1; c<NB_COLS+1; c++){
        printf("─────");
    }
    printf("|\n\n");
    printf("\n");
    

}
/*
    * Description :
        Réinitialise les directions possibles pour le joueur
    * Valeur de retour :
        Rien
*/

void reinitialiser_tableau_direction(int tableau_direction[]){
    int compteur = 1;
    for(int i = 0; i<9; i++){
        if(compteur == 5) tableau_direction[i] = 0;
        else tableau_direction[i] = compteur;
        compteur++;
    }
}

/*
    * Description :
        Demande la ligne et la colonne de la case que le joueur veut tuer et la tue
    * Valeur de retour :
        Rien
*/
void tuer_cellule(board jeu){
    char colonne_cellule;
    char ligne_cellule;
    
    int cellule_vise;
    do{
        printf("Indiquer la ligne de la cellule à tuer : ");
        scanf("%c", &ligne_cellule);
        while(getchar() != '\n');

        printf("Indiquer la colonne de la cellule à tuer : ");
        scanf("%c", &colonne_cellule);
        while(getchar() != '\n');
        
        //cellule_vise = get_content(jeu, ligne_cellule-'0'-1, colonne_cellule-'0'-1);
        cellule_vise = kill_cell(copy_game(jeu), ligne_cellule - '0' -1, colonne_cellule-'0'-1);
        affiche_message_erreur(cellule_vise);

    } while(cellule_vise != 0);
    kill_cell(jeu, ligne_cellule-'0'-1, colonne_cellule-'0'-1);


    
}

/*
    * Description : 
        Demande au joueur de choisir le mode de jeu
    * Valeur de retour :
        Le choix du jeu
*/

int choisir_jeu(){
    char chiffre;
    do{
        printf("Sélectionner le mode de jeu :\n");
        printf("(1) => Jeu classic\n");
        printf("(2) => Jeu avec portée\n");
        scanf("%c", &chiffre);
        while(getchar() != '\n');
    }while(chiffre-'0' != 1 && chiffre-'0' != 2);

    if(chiffre - '0' == 1) return 1;
    else return 0;
}


/*
    Lance une partie
*/
int main(){
    // Le tableau des directions disponibles pour le joueur
    int tableau_direction[9] = {1, 2, 3, 4, 0, 6, 7, 8, 9};

    // Initialise les tableaux des noms des joueurs (les noms sont insérés plus tard)
    char nom_joueur1[TAILLE_NOM];
    char nom_joueur2[TAILLE_NOM];


    board jeu;

    // Stocke le mode de jeu dans type_jeu
    int type_jeu = choisir_jeu();

    // Crée le jeu en fonction du choix du joueur
    if(type_jeu == 1) jeu = new_game();
    else jeu = new_special_game(0, 1);

    // Demande les noms des joueurs
    demande_nom(nom_joueur1);
    demande_nom(nom_joueur2);

    // Tant qu'il n'y a pas de gagnant, le jeu continue de tourner
    while(get_winner(jeu) == 0){
        // Ce printf permet d'effacer la console
        printf("\e[1;1H\e[2J");
        afficher_jeu(jeu);
        // Les conditions ternaires ci-dessous affichent le nom du joueur actuelle en fonction de la valeur de current_player
        printf("◢◢◢◢ %s - %s ◣◣◣◣\n\n", current_player(jeu) == 1 ? nom_joueur1 : nom_joueur2, current_player(jeu) == 1 ? "Nord" : "Sud");
        affiche_choisir_direction(current_player(jeu) == 1 ? nom_joueur1 : nom_joueur2, tableau_direction, jeu);
        move_toward(jeu, demande_direction(tableau_direction));
        printf("\e[1;1H\e[2J");
        afficher_jeu(jeu);
        tuer_cellule(jeu);
        // Réinitialise les directions à chaque tour
        reinitialiser_tableau_direction(tableau_direction);
    }
    printf("\e[1;1H\e[2J");
    // Affiche la fin du jeu
    afficher_jeu(jeu);
    printf("✰✰✰✰ Félicitation %s ! Vous avez gagné ! ✰✰✰✰\n\n", get_winner(jeu) == 1 ? nom_joueur1 : nom_joueur2);
    return 0;
}