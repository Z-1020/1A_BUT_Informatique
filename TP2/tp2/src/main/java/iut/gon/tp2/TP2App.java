package iut.gon.tp2;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.Optional;

public class TP2App extends Application {

  private BorderPane contenu;
  private ListView<String> gauche;
  private ListView<String> droite;
  private Button versGauche;
  private Button versDroite;
  private Button retireTout;
  private Button ajouteTout;
  private ButtonType fermer;
  int index;
  

  @Override
  public void start(Stage stage) throws IOException {
    FXMLLoader fxmlLoader = new FXMLLoader(TP2App.class.getResource("Tp2.fxml"));
    contenu = fxmlLoader.load();
    Scene scene = new Scene(contenu);
    extraitIds(scene);

    prepareMenus((MenuBar) scene.lookup("#menus"));
    prepareListe();
    prepareBoutons();
    prepareFermeture(stage);

    stage.setTitle("Gestion de groupe");
    stage.setScene(scene);
    stage.show();
  }

  /** Prépare la fenêtre pour demander confirmation avant fermeture */
  private void prepareFermeture(Stage stage) {
    stage.setOnCloseRequest(event -> {
    	stage.getOnCloseRequest();
    	ButtonType oui = new ButtonType("yes");
    	ButtonType non = new ButtonType("no");
    	Alert fermeture = new Alert(AlertType.CONFIRMATION);
    	fermeture.setContentText("Voulez-vous vraiment quitter l'application ?");
    	fermeture.setTitle("Fermeture de l'application");
    	Optional<ButtonType> res =fermeture.showAndWait();
    	if(res.get() == ButtonType.CANCEL) {
    		event.consume();
    	}
    	});
  }

  /** Prépare les actions des boutons */
  private void prepareBoutons() {
    ajouteTout.setOnAction(this::onAjouteTout);
    retireTout.setOnAction(this::onRetireTout);
    versDroite.setOnAction(this::deplacerVersDroite);
    versGauche.setOnAction(this::deplacerVersGauche);
    // TODO actions des deux boutons centraux
  }
  
  private void deplacerVersDroite(ActionEvent actionEvent) {
	  versDroite.setOnAction((deplacerverslagauche)-> {
		 index = gauche.getSelectionModel().getSelectedIndex();
		 if (index != -1) {
			 droite.getItems().add(""+gauche.getSelectionModel().getSelectedItem());
			 gauche.getItems().remove(index);
			 gauche.getSelectionModel().clearSelection();
		 }
	  });
  }
  
  private void deplacerVersGauche(ActionEvent actionEvent) {
	  versGauche.setOnAction((deplacerverslagauche)-> {
		 index = droite.getSelectionModel().getSelectedIndex();
		 if (index != -1) {
			 gauche.getItems().add(""+droite.getSelectionModel().getSelectedItem());
			 droite.getItems().remove(index);
			 droite.getSelectionModel().clearSelection();
		 }
	  });
  }

  /** Ajoute tous les éléments de gauche dans la liste de droite
   Active le bouton "Retirer tout" et désactive le bouton "Ajouter tout" */
  private void onAjouteTout(ActionEvent actionEvent) {
	  if(gauche.getItems() != null) {
		  ajouteTout.setDisable(false);
	  }
    droite.getItems().addAll(gauche.getItems());
    gauche.getItems().clear();
    //TODO active/désactive les boutons
    ajouteTout.setDisable(true);
    retireTout.setDisable(false);
  }

  /** Ajoute tous les éléments de droite dans la liste de gauche
   Active le bouton "Ajouter tout" et désactive le bouton "Retirer tout" */
  private void onRetireTout(ActionEvent actionEvent) {
	  retireTout.setDisable(true);
	  ajouteTout.setDisable(false);
	  gauche.getItems().addAll(droite.getItems());
	  droite.getItems().clear();
  }

  /** Prépare les menus et leurs événements */
  private void prepareMenus(MenuBar menus) {
    //TODO Remplir la barre de menus
	  Menu m1 = new Menu("_Fichier");
	  Menu m2 = new Menu("_Aide");
	  menus.getMenus().addAll(m1, m2);
	  MenuItem menuQuitter = new MenuItem("Quitter");
	  MenuItem menuAPropos = new MenuItem(" A propos");
	  m1.getItems().addAll(menuQuitter);
	  m2.getItems().addAll(menuAPropos);
	  menuQuitter.setOnAction((quitter) -> {
		  Platform.exit();
	  });
	  menuAPropos.setOnAction((propos)->{
		  ButtonType fermer = new ButtonType("close");
		  Alert boiteDeDialogue = new Alert(AlertType.NONE, "Voici une boite de dialogue", fermer.CLOSE);
		  boiteDeDialogue.setTitle("A propos");
		  boiteDeDialogue.show();
	  });
  }

  /**
   Remplit la liste de gauche avec des valeurs
   Active le bouton "Ajouter tout"
   */
  private void prepareListe() {
    //TODO active le bouton "Ajouter tout"
	  String nom1 = "nom1";
	  String nom2 = "nom2";
	  gauche.getItems().addAll(nom1,nom2);
	  ajouteTout.setDisable(false);
  }

  private void extraitIds(Scene scene) {
    gauche = (ListView<String>) scene.lookup("#gauche");
    droite = (ListView<String>) scene.lookup("#droite");
    versGauche = (Button) scene.lookup("#versGauche");
    versDroite = (Button) scene.lookup("#versDroite");
    retireTout = (Button) scene.lookup("#retireTout");
    ajouteTout = (Button) scene.lookup("#ajouteTout");
  }

  public static void main(String[] args) {
    launch();
  }
}
