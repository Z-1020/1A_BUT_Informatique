package iut.gon.tp3;

import javafx.application.Application;
import javafx.beans.InvalidationListener;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.input.KeyEvent;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * JavaFX App
 */
public class App extends Application {
	GrilleModel modele = new GrilleModel();
    private static Scene scene;

    @Override
    public void start(Stage stage) throws IOException {
    	
        FXMLLoader loader = new FXMLLoader(GrilleController.class.getResource(("tp3.fxml")));
        GrilleController gc = new GrilleController(modele);
        loader.setController(gc);
        Scene scene = new Scene(loader.load());
        stage.addEventHandler(KeyEvent.KEY_PRESSED, event -> {
    		switch (event.getText()) {
    		case "1" : modele.setCase(0,2, "Touche"); break;
    		case "2" : modele.setCase(1,2, "Touche"); break;
    		case "3" : modele.setCase(2,2, "Touche"); break;
    		case "4" : modele.setCase(0,1, "Touche"); break;
    		case "5" : modele.setCase(1,1, "Touche"); break;
    		case "6" : modele.setCase(2,1, "Touche"); break;
    		case "7" : modele.setCase(0,0, "Touche"); break;
    		case "8" : modele.setCase(1,0, "Touche"); break;
    		case "9" : modele.setCase(2,0, "Touche"); break;
    	
    		} // ce code permet d'afficher le mot "Touche" si on entre un chiffre entre 1 et 9 au clavier
    		});
        stage.setScene(scene);
        stage.show();
    }

    static void setRoot(String fxml) throws IOException {
        scene.setRoot(loadFXML(fxml));
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }

    public static void main(String[] args) {
        launch();
    }

}