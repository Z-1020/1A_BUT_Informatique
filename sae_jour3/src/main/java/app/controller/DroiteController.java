package app.controller;


import java.net.URL;
import java.util.HashMap;
import java.util.ResourceBundle;

import app.model.entity.Monster;
import app.model.map.Place;
import app.model.map.World;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TableView;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleButton;
import javafx.scene.input.MouseEvent;

public class DroiteController implements Initializable{
	private MainController droiteController;
	
	@FXML TextField textFieldId;
	@FXML TextField textFieldNomLieu;
	@FXML TextArea textAreaDescription;
	@FXML ToggleButton toggleButtonDebut;
	@FXML ToggleButton toggleButtonFin;
	@FXML ToggleButton toggleButtonDefaite;
	@FXML CheckBox checkBoxMonstre;
	@FXML TextField textFieldNomMonstre;
	@FXML TextField textFieldHP;
	@FXML TextField textFieldArmure;
	@FXML TextField textFieldAttaque;
	@FXML Button buttonDijkstra;
	@FXML Button button0;
	@FXML Button button1;
	@FXML Button button2;
	@FXML Button button3;
	@FXML Button button4;
	@FXML TextArea textArea;
	
	TableView<HashMap<Place, SimpleIntegerProperty>> tableDijkstra;
	ObservableList<HashMap<Place, SimpleIntegerProperty>> listeDijkstra;
	
	public void setDroitController(MainController controller) {
		/*this.droiteController = controller;
		textFieldId.textProperty().addListener((obs, oldV, newV)->{
			droiteController.selectedPlace.get().getId();
		});
		textFieldNomLieu.textProperty().bind(droiteController.selectedPlace.get().nameProperty());
		textAreaDescription.textProperty().bind(droiteController.selectedPlace.get().descriptionProperty());
		clickDijkstra();
		if(checkBoxMonstre.isFocused()) {
			textFieldNomMonstre.textProperty().bind(droiteController.selectedPlace.get().monsterProperty().get().name);
			textFieldHP.textProperty().bind(droiteController.selectedPlace.get().monsterProperty().get().getCurrentHPProperty().asString());
			textFieldArmure.textProperty().bind(droiteController.selectedPlace.get().monsterProperty().get().getArmorProperty().asString());
			textFieldAttaque.textProperty().bind(droiteController.selectedPlace.get().monsterProperty().get().getAttackProperty().asString());
		}
		textArea.getChildrenUnmodifiable().add(tableDijkstra);*/
	}

	@Override
	public void initialize(URL location, ResourceBundle resources) {
	}
	
	public void gererIsWin() {
		if(droiteController.selectedPlace.get().isEnd()) {
			toggleButtonDebut.setDisable(true);
		}
	}
		public void gererIsDefeat() {
			if(droiteController.selectedPlace.get().isDefeat()) {
				toggleButtonDebut.setDisable(true);
			}
		}
		public void gererIsStart() {
			if(droiteController.selectedPlace.get().isStart()) {
				toggleButtonDebut.setDisable(true);
			}
	}
		public void clickDijkstra() {
			if(droiteController.selectedPlace!= null) {
				buttonDijkstra.addEventHandler(MouseEvent.MOUSE_CLICKED, event ->{
					droiteController.launchDijkstra();
					System.out.println(1);
				});
			}
		}
}
