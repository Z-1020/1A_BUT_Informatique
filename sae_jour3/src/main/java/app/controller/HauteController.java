package app.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ResourceBundle;

import app.model.map.World;
import app.model.parser.JSONArray;
import app.model.parser.JSONParser;
import app.model.parser.WorldIO;
import javafx.beans.binding.BooleanBinding;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.stage.FileChooser;
import javafx.stage.FileChooser.ExtensionFilter;

public class HauteController {
	private MainController mainController;
	private  BooleanProperty isLoading = new SimpleBooleanProperty(false);
	
	@FXML
	private Button SaveWorld_Button;
	
	@FXML
	private Button LoadWorld_Button;
	
	public void setHauteController(MainController controller) {
		this.mainController = controller;
		BooleanBinding bind = isLoading.or(mainController.getIsDijkstraRunning()); //Creer un bind OR sur 2 boolean
		SaveWorld_Button.disableProperty().bind(bind); //Desactive les boutons si les condition sont respecter 
		LoadWorld_Button.disableProperty().bind(bind); //Desactive les boutons si les condition sont respecter
	}
	
	public void worldLoadChooser() throws IOException {
		FileChooser chooser = new FileChooser();
		FileChooser.ExtensionFilter filter = new ExtensionFilter("Json doc(.json)", "*.json"); //Créer un filtre pour garder que les fichier JSON
		chooser.getExtensionFilters().add(filter); //Ajoute le filtre
		File choosed = chooser.showOpenDialog(null);  //Creer la fenetre d'exploration fichier et enregistre le fichier selectionné
		if (choosed != null){ //Verifie que quelque chose est sélectionné pour éviter les erreurs
			InputStream stream = new FileInputStream(choosed); //Transforme en stream
			isLoading.set(true); // Pour desactiver les bouton grâce au bind
			World world = WorldIO.loadWorld(stream); // Charge le monde
			mainController.getCurrentWorld().setValue(world); //Donne le monde au mainController
			mainController.loadWorld(world); //Affiche le monde
			isLoading.setValue(false); // Reactive les bouton grâce au bind
			mainController.loadWorld(world);
		}
	}
	
	public void worldSaveChooser() throws IOException {
		FileChooser chooser = new FileChooser(); 
		File choosed = chooser.showSaveDialog(null); //Creer la fenetre d'exploration fichier et enregistre le fichier selectionné
		if (choosed != null){ //Verifie que quelque chose est sélectionné pour éviter les erreurs
			WorldIO.saveWorld(mainController.getCurrentWorld().get(), choosed); //Sauvegarde le monde
		}
	}

	
}

