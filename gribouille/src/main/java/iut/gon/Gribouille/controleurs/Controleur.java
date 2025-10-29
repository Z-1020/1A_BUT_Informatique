package iut.gon.Gribouille.controleurs;

import java.net.URL;
import java.util.ResourceBundle;

import iut.gon.Gribouille.Dialogues;
import iut.gon.Gribouille.modele.Dessin;
import iut.gon.Gribouille.modele.Figure;
import iut.gon.Gribouille.modele.Point;
import iut.gon.Gribouille.modele.Trace;
import javafx.application.Platform;
import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.canvas.Canvas;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.paint.Paint;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

public class Controleur implements Initializable {
	public final Dessin dessin = new Dessin();
	public  Figure figure;
	public final  SimpleDoubleProperty precX = new SimpleDoubleProperty(0);
	public final  SimpleDoubleProperty precY = new SimpleDoubleProperty(0);
	
	@FXML
	public MenusControleur menusController;
	
	@FXML
	public DessinControleur dessinController;
	
	@FXML
	public StatutControleur statutController;
	
	@FXML
	public CouleursControleur couleurController;
	
	public final SimpleObjectProperty<Color> couleur = new SimpleObjectProperty<Color>(Color.BLACK);
	public  SimpleIntegerProperty epaisseur = new SimpleIntegerProperty(1);
	public Outil outil = new OutilCrayon(this);
	
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		menusController.setMenusControleur(this);
		dessinController.setDessinControleur(this);
		statutController.setStatutControleur(this);
		couleurController.setCouleursControleur(this);
		statutController.labelY.textProperty().bind(precX.asString());
    	statutController.labelX.textProperty().bind(precY.asString());
    	statutController.labelEpaisseur.textProperty().bind(epaisseur.asString());
    	statutController.couleur.textProperty().bind(couleur.asString());
		
	}


	public Dessin getDessin() {
		return dessin;
	}

	public Figure getFigure() {
		return figure;
	}


	public void setFigure(Figure figure) {
		this.figure = figure;
	}
	public SimpleObjectProperty<Color> getCouleur() {
		return couleur;
	}


	public SimpleIntegerProperty getEpaisseur() {
		return epaisseur;
	}
	public void setEpaisseur(SimpleIntegerProperty epaisseur) {
		this.epaisseur = epaisseur;
	}
	
	public void onQuitter(Stage stage) {
		stage.setOnCloseRequest( event-> {
        	Dialogues d = new Dialogues();
        	if (d.confirmation() == true) {
        		Platform.exit();
        	}
        	else {
        		event.consume();
        	}
        	
	});
    }
	public void efface() {
		
		dessinController.canvas.getGraphicsContext2D().clearRect(0,0,dessinController.canvas.getWidth(), dessinController.canvas.getHeight());
	}
	
	public void trace(double x1, double y1, double x2, double y2 ) {
		dessinController.canvas.getGraphicsContext2D().strokeLine(x1, y1, x2, y2);
	}
	
	public void dessine(MouseEvent event) {
    		dessinController.canvas.getGraphicsContext2D().strokeLine(precX.get(), precY.get(), event.getX(), event.getY());
    		precX.set(event.getX());
    		precY.set(event.getY());
    }
	
	public void onMouseMove(MouseEvent event) {
		statutController.labelY.textProperty().bind(precX.asString());
    	statutController.labelX.textProperty().bind(precY.asString());
    	
	}
	
	public void onEtoile(){
		this.outil = new OutilEtoile(this);
	}
	public void onCrayon() {
		this.outil = new OutilCrayon(this);
		
	}
	public void setCouleur(Paint couleur) {
		this.couleur.setValue((Color) couleur);
		dessinController.setCouleur(couleur);
	}
	
	public void onKeyPressed(String text) {
		switch(text) {
		case "e": onEtoile(); break;
		case "c": onCrayon();break;
		case "1": dessinController.setEpaisseur(1);break;
		case "2": dessinController.setEpaisseur(2);break;
		case "3": dessinController.setEpaisseur(3);break;
		case "4": dessinController.setEpaisseur(4);break;
		case "5": dessinController.setEpaisseur(5);break;
		case "6": dessinController.setEpaisseur(6);break;
		case "7": dessinController.setEpaisseur(7);break;
		case "8": dessinController.setEpaisseur(8);break;
		case "9": dessinController.setEpaisseur(9);break;
		case "r": dessinController.setCouleur(couleurController.rectangle1.getFill());break;
		case "v": dessinController.setCouleur(couleurController.rectangle2.getFill());break;
		case "b": dessinController.setCouleur(couleurController.rectangle3.getFill());break;
		case "y": dessinController.setCouleur(couleurController.rectangle4.getFill());break;
		case "m": dessinController.setCouleur(couleurController.rectangle5.getFill());break;
		case "j": dessinController.setCouleur(couleurController.rectangle6.getFill());break;
		case "n": dessinController.setCouleur(couleurController.rectangle7.getFill());break;
		case "w": dessinController.setCouleur(couleurController.rectangle8.getFill());break;
		
		}
	}
	
	public void sauvegarder() {
		FileChooser sauvegarde = new FileChooser();
		sauvegarde.setTitle("sauvegarde");
		menusController.sauvegarder.setOnAction( event ->{
			dessin.fichier = sauvegarde.showSaveDialog(null);
			dessin.sauveSous(dessin.fichier.getAbsolutePath());
			dessin.setNomDuFichier(dessin.fichier.getAbsolutePath());
			System.out.println(dessin.fichier.getAbsolutePath());
			
			
		});
	}
	
	public void charger() {
		FileChooser ouvrir = new FileChooser();
		menusController.charger.setOnAction(event->{
			dessin.fichier = ouvrir.showOpenDialog(null);
			dessin.charge(dessin.fichier.getAbsolutePath());
		});
	}
	

}
