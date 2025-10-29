package fr.unicaen.iut.tp5;

import java.net.URL;
import java.util.ResourceBundle;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;
import javafx.scene.control.RadioMenuItem;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleGroup;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Background;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.ColumnConstraints;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.RowConstraints;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Paint;

public class ControllerDemineur implements Initializable {
	public ModeleDemineur modele = new ModeleDemineur(0,0,0);
	
	@FXML private GridPane gridPane;
	@FXML private VBox vBox;
	@FXML private TextField textFieldInconnu;
	@FXML private TextField textFielMarque;
	@FXML private ToggleGroup groupe;
	@FXML private HBox hbox;
	@FXML private BorderPane borderPane;
	@FXML private Menu menuJeu;
	@FXML private Menu menuChoixDifficulte;
	@FXML private MenuBar menuBar;
	@FXML private MenuItem menuQuitter;
	@FXML private RadioMenuItem menuFacile;
	@FXML private RadioMenuItem menuMoyen;
	@FXML private RadioMenuItem menuDifficile;
	

	
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		groupe.selectedToggleProperty().addListener((obs, nouvelle, ancienne) ->{
			initGrille(groupe.getSelectedToggle().getUserData().toString());
		});
		textFieldInconnu.textProperty().bind(modele.nbInconnuesProperty().asString());
		textFielMarque.textProperty().bind(modele.nbMarquesProperty().asString());

	
		
		
	}
	
	public void initGrille(String userData) {
		int[] tab = new int[3];
		gridPane.getColumnConstraints().clear();
		gridPane.getRowConstraints().clear();
		 tab = modele.parseUserData(userData);
		ModeleDemineur modele = new ModeleDemineur(tab[0], tab[1], tab[2]);
		gridPane.setGridLinesVisible(true);
		for(int i=0; i<tab[0]; i++) {
			gridPane.getRowConstraints().add(new RowConstraints(32));
		}
		for(int j=0; j<tab[1]; j++) {
			gridPane.getColumnConstraints().add(new ColumnConstraints(32));
		}
		textFieldInconnu.textProperty().bind(modele.nbInconnuesProperty().asString());
		textFielMarque.textProperty().bind(modele.nbMarquesProperty().asString());
		System.out.println(gridPane.getRowCount());
		System.out.println(gridPane.getColumnCount());
		for(int i=0; i<gridPane.getRowCount(); i++) {
			for(int j=0; j<gridPane.getColumnCount(); j++) {
				Label label = new Label();
				label.setPrefSize(31, 31);
				label.setStyle("-fx-background-color: AQUA");
				label.setText(modele.getText(j, i));
				int x =i;
				int y =j;
				gridPane.add(label, i, j);
				
			}
			
			}
		
	}
	

}
