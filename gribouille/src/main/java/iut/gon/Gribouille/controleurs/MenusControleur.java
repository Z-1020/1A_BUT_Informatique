package iut.gon.Gribouille.controleurs;

import java.net.URL;
import java.util.ResourceBundle;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;
import javafx.scene.control.RadioMenuItem;
import javafx.scene.control.ToggleGroup;
import javafx.scene.input.MouseEvent;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

public class MenusControleur implements Initializable {
	
	public @FXML Controleur controleur;
	
	@FXML
	public MenuBar menuBar;
	@FXML
	public ToggleGroup radiogroup1;
	@FXML
	public ToggleGroup menuGroup;
	@FXML
	public Menu aide;
	@FXML
	public MenuItem aPropos;
	@FXML
	public MenuItem quitter;
	@FXML
	public MenuItem sauvegarder;
	@FXML
	public MenuItem charger;
	@FXML
	public MenuItem exporter;
	@FXML
	public Menu dessin;
	@FXML
	public Menu outils;
	@FXML
	public Menu epaisseur;
	@FXML
	public RadioMenuItem etoile;
	@FXML
	public RadioMenuItem crayon;
	@FXML
	public RadioMenuItem ep1;
	@FXML
	public RadioMenuItem ep2;
	@FXML
	public RadioMenuItem ep3;
	@FXML
	public RadioMenuItem ep4;
	@FXML
	public RadioMenuItem ep5;
	@FXML
	public RadioMenuItem ep6;
	@FXML
	public RadioMenuItem ep7;
	@FXML
	public RadioMenuItem ep8;
	@FXML
	public RadioMenuItem ep9;
	
	
	
	
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		menuGroup.selectedToggleProperty().addListener((obs, ancienne, nouvelle)->{
			if(crayon.isSelected()) {
				controleur.onCrayon();
			}
			else {
				controleur.onEtoile();
			}
	
		});
		radiogroup1.selectedToggleProperty().addListener((obs, ancienne, nouvelle)->{
			if(ep1.isSelected()) {
				controleur.dessinController.setEpaisseur(1);
			}
			else if(ep2.isSelected()) {
				controleur.dessinController.setEpaisseur(2);
			}
			else if(ep3.isSelected()) {
				controleur.dessinController.setEpaisseur(3);
			}
			else if(ep4.isSelected()) {
				controleur.dessinController.setEpaisseur(4);
			}
			else if(ep5.isSelected()) {
				controleur.dessinController.setEpaisseur(5);
			}
			else if(ep6.isSelected()) {
				controleur.dessinController.setEpaisseur(6);
			}
			else if(ep7.isSelected()) {
				controleur.dessinController.setEpaisseur(7);
			}
			else if(ep8.isSelected()) {
				controleur.dessinController.setEpaisseur(8);
			}
			else if(ep9.isSelected()) {
				controleur.dessinController.setEpaisseur(9);
			}
			
		});
		
	}
	public void setMenusControleur(Controleur ctl) {
		controleur = ctl;
	}
	
	public void onQuitte(Stage stage) {
		this.controleur.onQuitter(stage);
	}
	
	public void sauvegarder() {
		controleur.sauvegarder();
	}
	
	

}
