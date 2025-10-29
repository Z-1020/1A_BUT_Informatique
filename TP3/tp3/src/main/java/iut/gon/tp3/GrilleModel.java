package iut.gon.tp3;

import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import javafx.scene.control.Label;

public class GrilleModel {
	
	
	public String[][]  tab = new String[3][3];	//créer un tableau de chaine de caractères
	
	//créer un tableau de StringProperty initialisé
	public SimpleStringProperty[][] tabPropriete = new SimpleStringProperty[][] {	
		{new SimpleStringProperty(" "), new SimpleStringProperty(" "), new SimpleStringProperty(" ")},
		{new SimpleStringProperty(" "), new SimpleStringProperty(" "), new SimpleStringProperty(" ")},
		{new SimpleStringProperty(" "), new SimpleStringProperty(" "), new SimpleStringProperty(" ")}};
	
		//initialise le tableau de chaine de caractère
	public GrilleModel() {
		for(int i=0; i<3; i++) {
			for(int j=0; j<3; j++) {
				tab[i][j] = "Bonjour";
			}
		}
	}
	

	// retourne la propriété contenu dans le tableau de proprété
	public StringProperty getSimpleStringProperty(int lg, int col) {
		return tabPropriete[lg][col];
	}


	//modifie la valeur contenu dans le tableau de propriété
	public void setSimpleStringProperty(String stringProperty, int lg, int col) {
		this.tabPropriete[lg][col].set(stringProperty);
	}


	//modifie le tableau de chaine de caractère et le tableau de propriété
	public void setCase(int lg, int col, String texte) {
		tabPropriete[lg][col].set(texte);
		tab[lg][col] = texte;
	}
	
	//retourne la case du tableau de chaine de caractère 
	public String getCase(int lg, int col) {
		return tab[lg][col];
	}
	
	//change au clic de la souris, le text du label
	public void clicLabel(Label l, int lg, int col) {
		l.setOnMouseClicked(event -> {
			setCase(lg, col, "Au revoir"); 
			
		});
	}
}
