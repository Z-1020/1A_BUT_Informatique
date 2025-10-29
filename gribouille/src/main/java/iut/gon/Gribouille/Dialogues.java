package iut.gon.Gribouille;

import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;

public class Dialogues {
	public Dialogues() {
		
	}
	
	public static boolean confirmation() {
		Alert boiteDeDialogue = new Alert(AlertType.CONFIRMATION);
		boiteDeDialogue.setContentText("Voulez-vous vraiment quitter l'application ?");
		boiteDeDialogue.setTitle("Fermeture de la fenêtre");
		if(boiteDeDialogue.showAndWait().get() == ButtonType.OK) {
			return true;
		}
		return false;
		
	}
}
