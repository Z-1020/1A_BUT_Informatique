package iut.gon.tp3;

import java.net.URL;
import java.util.ResourceBundle;

import javafx.beans.property.SimpleStringProperty;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.control.Label;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Font;
import javafx.scene.text.TextAlignment;

public class GrilleController implements Initializable{
	private @FXML GridPane grille;
	public GrilleModel modele;
	
	public GrilleController(GrilleModel grilleModel) {
		this.modele = grilleModel;
	}
	
	@Override
	public void initialize(URL url, ResourceBundle ressource) {
		grille.setStyle("-fx-background-color: seashell"); //modifie la couleur de l'arrière plan de la grille
		Label tabLabel[][] = new Label[3][3]; //créer un tableau de label
		
		for(int i =0; i<3; i++) {
			for(int j=0; j<3; j++) {
				Label label = new Label();	//créer un nouveau label
				
				label.setMaxSize(1000, 1000); 	//modifie la taille du label
				label.setAlignment(Pos.CENTER); 	// modifie l'alignement du label dans la grille
				label.setTextAlignment(TextAlignment.CENTER);	//modifie l'alignement du texte dans le label
				
				label.setText(modele.getCase(j, i));	//modifie le text du label avec le contenu du tableau de chaîne de caractère
				modele.clicLabel(label, i, j); 		// fonction qui permet de changer le text au clic de la souris
				tabLabel[i][j] = label;		 //ajoute le label  au tableau de label tabLabel à la colonne j et à la ligne i
				modele.setSimpleStringProperty(modele.tab[i][j], i, j);		//modifie les valeurs du tableau contenant les propriétés, avec la valeur du tableau de chaine de caractère
				grille.add( label, i, j); // ajoute les labels à la grille 
			}
		}
		for(int i =0; i<3; i++) {
			for(int j=0; j<3; j++) {
				tabLabel[i][j].textProperty().bind(modele.tabPropriete[i][j]);	//lie la propriété contenu dans le tableau de propriété à la propriété du label
			}
		}
	}
}
