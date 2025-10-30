/*
    Groupe : 
        - Brice Ramette
        - Zoé Margerie
*/

#include <stdio.h>
#include <stdlib.h>
#include "board.h"


/**
 * \file board.c
 *
 * \brief Source code associated with \ref board.h
 *
 * \author you
 */
/**
 * @brief The board of the game.
 */
struct board_s {
	// TODO: choisir une structure adaptee
    cell grid[MAX_DIMENSION][MAX_DIMENSION];
    bool is_hexa;
    bool rule_range;
    bool player_north_must_play;
    bool player_has_already_moved;
    int north_pos[2];
    int south_pos[2];

};


/*
    Fonctions internes
*/
int * convert_pos_to_arr(board game, direction direction){
    int *arr_pos = malloc(2*sizeof(int));
    
    if(is_hex(game)){
        switch(direction){
        
        case SW:
            arr_pos[0] = 1;
            arr_pos[1] = 0;
            break;
        case SE:
            arr_pos[0] = 1;
            arr_pos[1] = 1;
            break;
        case S:
            arr_pos[0] = 1;
            arr_pos[1] = 0;
            break;
        case W:
            arr_pos[0] = 0;
            arr_pos[1] = -1;
            break;
        case E:
            arr_pos[0] = 0;
            arr_pos[1] = 1;
            break;
        case NW:
            arr_pos[0] = -1;
            arr_pos[1] = -1;
            break;
        case N:
            arr_pos[0] = -1;
            arr_pos[1] = 0;
            break;
        case NE:
            arr_pos[0] = -1;
            arr_pos[1] = 0;
            break;
    }
    } else{
        switch(direction){
        
        case SW:
            arr_pos[0] = 1;
            arr_pos[1] = -1;
            break;
        case S:
            arr_pos[0] = 1;
            arr_pos[1] = 0;
            break;
        case SE:
            arr_pos[0] = 1;
            arr_pos[1] = 1;
            break;
        case W:
            arr_pos[0] = 0;
            arr_pos[1] = -1;
            break;
        case E:
            arr_pos[0] = 0;
            arr_pos[1] = 1;
            break;
        case NW:
            arr_pos[0] = -1;
            arr_pos[1] = -1;
            break;
        case N:
            arr_pos[0] = -1;
            arr_pos[1] = 0;
            break;
        case NE:
            arr_pos[0] = -1;
            arr_pos[1] = 1;
            break;
    }
    }

    return arr_pos;
}

bool is_valid_direction(board game, direction direction){
    if(direction <0 || direction>7) return false;
    else if(is_hex(game) && (direction == S || direction == N)) return false;
    else return true;
}


/* Cette fonction sert a verifier si la cellule est dans le tableau, la fonction prend en parametre le jeu et les coordonnée de la cellule a tuer */

bool is_out_grid(board game, int line, int column){
    
// verifie la cellule dans le plateau hexagonal

    if(is_hex(game)){
//verifie si les cordonnees sont situe hors du tableau et retourne vrai
        if(line<0 || column <0 || line>=MAX_DIMENSION || column >= MAX_DIMENSION) return true;
        return false;

//verifie la cellule dans le plateau rectangulaire

    } else{
// verifie si la cellule est hors du tableau et retourne vrai
        // ERREUR AVEC LE KILLED
        if(line <0 || line >= NB_LINES || column <0 || column >= NB_COLS) return true;
        return false;
    }
}

bool possible_range(board game, int line_kill, int col_kill){
    int arr[MAX_DIMENSION][MAX_DIMENSION];
    printf("TEEEEST\n");
    for(int i=0; i<MAX_DIMENSION; i++){
        for(int j=0; j<MAX_DIMENSION; j++){
            arr[i][j] = -2;
        }
    }
    
    if(current_player(game) == NORTH) arr[game->north_pos[0]][game->north_pos[1]] = 0;
    else arr[game->south_pos[0]][game->south_pos[1]] = 0;


    for(int k=1; k<=KING_RANGE; k++){
        for(int i=0; i<MAX_DIMENSION; i++){
            for(int j=0; j< MAX_DIMENSION; j++){
                for(int l=-1; l<=1; l++){
                    for(int c=-1; c<=1; c++){
                        if(!is_out_grid(game, i+l, j+c)){
                            if(is_hex(game)){
                                if(arr[i][j] == k-1 && arr[i+l][j+c] == -2){
                                    if( (l!=1 || c!=-1) && (l!=-1 || c!=1) ){
                                        arr[i+l][j+c] = k;
                                    } 
                                }
                                if( !is_out_grid(game, i, j) && get_content(game, i, j) != EMPTY && arr[i][j] != 0){
                                    // printf("OUI\n");
                                    arr[i][j] = -1;
                                }

                            } else{

                                if(arr[i][j] == k-1 && arr[i+l][j+c] == -2){
                                    arr[i+l][j+c] = k;
                                }
                                if( !is_out_grid(game, i, j) && get_content(game, i, j) != EMPTY && arr[i][j] != 0){
                                    // printf("OUI\n");
                                    arr[i][j] = -1;
                                }
                            }

                        }
                    }
                }                
            }
        }
    }

    int number = arr[line_kill][col_kill];
    printf("%d\n", number);

    for(int i=0;i<MAX_DIMENSION;i++){
        for(int j=0;j<MAX_DIMENSION; j++){
            printf("|%2d| ", arr[i][j]);
        }
        printf("\n");
    }
    if(number>0 && number <=KING_RANGE) return true;
    else return false;
}



void update_pos_player(board game, player player, direction direction){
    int *direction_pos = convert_pos_to_arr(game, direction);
    int direction_line_pos = direction_pos[0];
    int direction_col_pos = direction_pos[1];
    int player_line_pos;
    int player_col_pos;

    if(player == NORTH){
        player_line_pos = game->north_pos[0];
        player_col_pos = game->north_pos[1];
        game->grid[player_line_pos+direction_line_pos][player_col_pos+direction_col_pos] = NORTH_KING;
        game->grid[player_line_pos][player_col_pos] = EMPTY;
        game->north_pos[0] = player_line_pos+direction_line_pos;
        game->north_pos[1] = player_col_pos+direction_col_pos;
    } else{
        player_line_pos = game->south_pos[0];
        player_col_pos = game->south_pos[1];
        game->grid[player_line_pos+direction_line_pos][player_col_pos+direction_col_pos] = SOUTH_KING;
        game->grid[player_line_pos][player_col_pos] = EMPTY;
        game->south_pos[0] = player_line_pos+direction_line_pos;
        game->south_pos[1] = player_col_pos+direction_col_pos;
    }
}

board new_special_game(bool is_hex, bool use_range){
    if(!is_hex){
        board new_board = malloc(sizeof(struct board_s));
        new_board->is_hexa = false;
        new_board->rule_range = use_range;
        new_board->player_north_must_play = true;
        new_board->player_has_already_moved = false;

        for(int i=0; i<MAX_DIMENSION; i++){
            for(int j=0; j<MAX_DIMENSION; j++){
                new_board->grid[i][j] = KILLED;
                
            }
        }

        for(int i=0; i<NB_LINES; i++){
            for(int j=0; j<NB_COLS; j++){
                new_board->grid[i][j] = EMPTY;
            }
        }

        new_board->grid[0][3] = NORTH_KING;
        new_board->grid[NB_LINES-1][3] = SOUTH_KING;

        new_board->north_pos[0] = 0;
        new_board->north_pos[1] = 3;

        new_board->south_pos[0] = NB_LINES-1;
        new_board->south_pos[1] = 3;
        return new_board;
    }
    else{
        board game = malloc(sizeof(struct board_s));
        game->is_hexa=is_hex;
        game->player_has_already_moved = false;
        game->player_north_must_play = true;
        game->rule_range = use_range;

        // Gère les cellules killed
        for(int i=0; i<MAX_DIMENSION; i++){
            for(int j=0; j<MAX_DIMENSION; j++){
                game->grid[i][j] = KILLED;
            }
        }

        int left_killed = 0;
        int right_killed = HEX_SIDE;
        for(int i=0; i<MAX_DIMENSION; i++){
            for(int j=left_killed; j<=MAX_DIMENSION-right_killed; j++){
                
                game->grid[i][j] = EMPTY;
            }
            
            if(i<HEX_SIDE-1) right_killed--;
            if(i>HEX_SIDE-1){
                left_killed++;
                right_killed = 1;
            }
            if(i==HEX_SIDE-1){
                right_killed = 1;
                left_killed = 1;
            }
        }

        game->grid[0][HEX_SIDE/2] = NORTH_KING;
        game->grid[MAX_DIMENSION-1][MAX_DIMENSION/2 + HEX_SIDE/2] = SOUTH_KING;

        game->north_pos[0] = 0;
        game->north_pos[1] = HEX_SIDE/2;

        game->south_pos[0] = MAX_DIMENSION-1;
        game->south_pos[1] = MAX_DIMENSION/2 + HEX_SIDE/2;
        return game;
    }
}

board new_game(){
	return new_special_game(false, false);
}

board copy_game(board original_game){
	board new_board = malloc(sizeof(struct board_s));

    new_board->is_hexa = original_game->is_hexa;
    new_board->rule_range = original_game -> rule_range;
    new_board->player_north_must_play = original_game->player_north_must_play;
    new_board->player_has_already_moved = original_game->player_has_already_moved;

    for(int i=0; i<MAX_DIMENSION; i++){
        for(int j=0; j<MAX_DIMENSION; j++){
            new_board->grid[i][j]=original_game->grid[i][j];
        } 
    }
    for(int k=0; k<2; k++){
        new_board->north_pos[k] = original_game->north_pos[k];
        new_board->south_pos[k] = original_game->south_pos[k]; 
    }
    
	// TODO copier la situation de l'ancien jeu dans le nouveau.
    
	return new_board;
}

void destroy_game(board game){
	free(game);
};

// TODO ajouter les entêtes des autres fonctions et completer.
/*Fonction qui renvoie vrai lorsque le joueur selectionne le plateau hexagonal */
bool is_hex(board game){
    return game->is_hexa;
}
/*Fonction qui renvoie vrai lorsque le joueur selectionne la règle de portée */
bool uses_range(board game){
    return game->rule_range;
}

player current_player(board game){
    return game->player_north_must_play ? NORTH : SOUTH;
}

cell get_content(board game, int line, int column){
    if(is_out_grid(game, line, column) == true || game->grid[line][column] == KILLED) return KILLED;
    else return game->grid[line][column];
}

/* la fonction retourne le joueur gagnant*/
player get_winner(board game){
    int compteur_case=0;
    board new_game;
// on test si le joueur nord peut se deplacer
    if(current_player(game)==NORTH){
// on verifie que c'est une grille classique
        for(int i=0; i<8; i++){
// on crée une copie du jeu pour lui appliqué la fonction move_toward
            new_game = copy_game(game);
            new_game->player_has_already_moved = false;
            if(move_toward(new_game, i) != OK){
                compteur_case++;
// si pour une direction la fonction move_toward renvoie autre
            }
        }
        destroy_game(new_game);
        if(compteur_case==8 ) return SOUTH;
    }
    else{
        for(int i=0; i<8; i++){
            new_game = copy_game(game);
            new_game->player_has_already_moved = false;
            if(move_toward(new_game, i) != OK){
                compteur_case++;
            }
        }
        destroy_game(new_game);
        if(compteur_case==8) return NORTH;
    }
    
    return NO_PLAYER;
}


enum return_code move_toward(board game, direction direction){
    int *pos_arr = convert_pos_to_arr(game, direction);

    int new_line_player;
    int new_col_player;
    cell content;
    if(!is_valid_direction(game, direction) || game->player_has_already_moved) return RULES;

    if(current_player(game) == NORTH){
        
        new_line_player = game->north_pos[0] + pos_arr[0];
        new_col_player = game->north_pos[1] + pos_arr[1];
        content = get_content(game, new_line_player, new_col_player);
        if(content == KILLED || is_out_grid(game, new_line_player, new_col_player)) return OUT;
        if(content == SOUTH_KING) return BUSY;
        update_pos_player(game, NORTH, direction);
        
    } else{
        
        new_line_player = game->south_pos[0] + pos_arr[0];
        new_col_player = game->south_pos[1] + pos_arr[1];
        content = get_content(game, new_line_player, new_col_player);
        
        if(content == KILLED || is_out_grid(game, new_line_player, new_col_player)) return OUT;
        if(content == NORTH_KING) return BUSY;
        update_pos_player(game, SOUTH, direction);
    }

    game->player_has_already_moved = true;
    free(pos_arr);
    return OK;
}
enum return_code kill_cell(board game, int line, int column){
    if(game->player_has_already_moved==false){
        return RULES;
    }
    if(is_out_grid(game, line, column)==true || get_content(game, line, column) == KILLED){
        return OUT;
    }
    if(get_content(game, line, column)!= EMPTY && get_content(game, line, column) != KILLED){
        return BUSY;
    }
    if(uses_range(game)==true){
        if(possible_range(game, line, column)==false){
            return RULES;
        }
    }
    
    game->grid[line][column] = KILLED;

    game->player_has_already_moved = false;
    game->player_north_must_play = !game->player_north_must_play;
    return OK;
}