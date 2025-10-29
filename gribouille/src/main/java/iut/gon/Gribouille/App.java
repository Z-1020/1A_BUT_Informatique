package iut.gon.Gribouille;

import javafx.application.Application;
import javafx.event.Event;
import javafx.event.EventType;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;

import java.io.IOException;

import iut.gon.Gribouille.controleurs.Controleur;
import iut.gon.Gribouille.controleurs.CouleursControleur;
import iut.gon.Gribouille.controleurs.DessinControleur;
import iut.gon.Gribouille.controleurs.MenusControleur;
import iut.gon.Gribouille.controleurs.StatutControleur;
import iut.gon.Gribouille.modele.Dessin;

/**
 * JavaFX App
 */
public class App extends Application {
	private double prevX;
	private double prevY;
    private static Scene scene;
    private Canvas canvas;
    private Pane pane;
    public MenusControleur menusControleur;
	public DessinControleur dessinControleur;
	public StatutControleur statutControleur;
	public CouleursControleur couleursControleur;

    @Override
    public void start(Stage stage) throws IOException {
    	
    	Dessin dessin = new Dessin();
    	FXMLLoader loader = new FXMLLoader(App.class.getResource("CadreGribouille.fxml"));
    	
        scene = new Scene(loader.load());
        stage.setScene(scene);
        Controleur controleur = loader.getController();
        
        stage.titleProperty().bind(controleur.dessin.nomDuFichierProperty());
        stage.addEventHandler(KeyEvent.KEY_PRESSED, event->{
        	controleur.onKeyPressed(event.getText());
        });
        controleur.sauvegarder();
        controleur.charger();
        stage.show();
        	controleur.onQuitter(stage);
        
    }
    
    
    public void recupererXetY() {
    	canvas.addEventHandler(MouseEvent.MOUSE_PRESSED , event ->{
    		prevX = event.getX();
    		prevY = event.getY();
    	});
    	
    }
    
    public void dessiner() {
    	canvas.addEventHandler(MouseEvent.MOUSE_DRAGGED , event ->{
    		canvas.getGraphicsContext2D().strokeLine(prevX, prevY, event.getX(), event.getY());
    		prevX = event.getX();
    		prevY = event.getY();
		});
    }

    static void setRoot(String fxml) throws IOException {
        scene.setRoot(loadFXML(fxml));
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }
    public void extraitIDs(Scene scene) {
    
    	
    }
    
    public static void main(String[] args) {
        launch();
    }

}