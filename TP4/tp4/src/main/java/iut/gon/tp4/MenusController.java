package iut.gon.tp4;

import java.io.IOException;

import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.layout.GridPane;

public class MenusController {
	  
	public GrilleModel modele;
	public Scores table;
	


	public @FXML GridPane grille;
	@FXML
	  public void onMenuNouvelle(ActionEvent evt) {
	    modele.nouvellePartie();
	  }
	  @FXML
	  public void onMenuTable(ActionEvent evt) throws IOException  {
		  FXMLLoader fxmlLoader = new FXMLLoader(TableController.class.getResource("table.fxml"));
		  Parent parent = fxmlLoader.load() ;
		  TableController tc = fxmlLoader.getController();
		  tc.setScores(table);
		 grille.getScene().setRoot(parent);

	  }

	  @FXML
	  public void onMenuQuitter(ActionEvent evt) {
	    Platform.exit();
	  }
	  
	  public void setParam(GrilleModel grilleModel, Scores scores, GridPane grille) {
		  this.modele = grilleModel;
		  this.table = scores;
		  this.grille = grille;
	  }
}
