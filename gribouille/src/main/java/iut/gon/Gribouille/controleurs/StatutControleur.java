package iut.gon.Gribouille.controleurs;

import java.net.URL;
import java.util.ResourceBundle;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;

public class StatutControleur implements Initializable{
	
	public @FXML Controleur controleur;
	
	@FXML
	public GridPane statut;
	@FXML
	public Label labelX;
	@FXML
	public Label labelY;
	@FXML
	public Label labelEpaisseur;
	@FXML
	public Label outil;
	@FXML
	public Label couleur;
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
	}
	public void setStatutControleur(Controleur ctl) {
		this.controleur = ctl;
		outil.textProperty().bind(controleur.menusController.menuGroup.selectedToggleProperty().asString());
	}

}
