package fr.unicaen.iut.tp5;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * JavaFX App
 */
public class Demineur extends Application {
	
	private ModeleDemineur modele = new ModeleDemineur(3,3,3);
    private static Scene scene;

    @Override
    public void start(Stage stage) throws IOException {
    	
    	FXMLLoader loader = new FXMLLoader(ControllerDemineur.class.getResource("demineur.fxml"));
        scene = new Scene(loader.load());
        stage.setScene(scene);
        ControllerDemineur controler = loader.getController();
        stage.show();
    }

    static void setRoot(String fxml) throws IOException {
        scene.setRoot(loadFXML(fxml));
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Demineur.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }

    public static void main(String[] args) {
        launch();
    }

}