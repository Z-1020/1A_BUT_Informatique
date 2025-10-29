package iut.gon.tp4;

import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import iut.gon.tp4.Scores.Entree;

public class TableController {
  public Label nbNulles;
  private Scores scores;

  @FXML public TableView<Scores.Entree> table;

  public void onFermer(ActionEvent event) throws IOException {
	  GrilleController gc = new GrilleController(scores);
	  FXMLLoader fxmlLoader = new FXMLLoader(GrilleController.class.getResource("grille.fxml"));
	  fxmlLoader.setController(gc);
	  Parent parent = fxmlLoader.load();
	  gc = fxmlLoader.getController();
	  table.getScene().setRoot(parent);

	 
	   }

  public void onReinit(ActionEvent event) {
    scores.reinitialiser();
  }

  public void setScores(Scores scores) {
    this.scores = scores;
    table.setItems(scores.getScores());
    table.getColumns().get(0).setCellValueFactory(new PropertyValueFactory<>("joueur"));
    table.getColumns().get(1).setCellValueFactory(new PropertyValueFactory<>("victoires"));
    nbNulles.textProperty().set(String.valueOf(scores.getNulles()));
  }
}
