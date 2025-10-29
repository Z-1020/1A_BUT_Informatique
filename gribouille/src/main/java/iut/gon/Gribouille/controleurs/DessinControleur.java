package iut.gon.Gribouille.controleurs;

import java.net.URL;
import java.util.ResourceBundle;

import iut.gon.Gribouille.modele.Dessin;
import iut.gon.Gribouille.modele.Figure;
import iut.gon.Gribouille.modele.Point;
import iut.gon.Gribouille.modele.Trace;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.canvas.Canvas;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Paint;

public class DessinControleur implements Initializable{
	
	public @FXML Controleur controleur;
	
	@FXML
	public  Canvas canvas;
	
	@FXML
	public Pane pane;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		canvas.widthProperty().bind(pane.widthProperty());
    	canvas.heightProperty().bind( pane.heightProperty());
    	canvas.widthProperty().addListener((obs, nouvelle, ancienne)->{
            for(Figure fig : controleur.dessin.getFigures()) {
                controleur.precX.set(fig.getPoints().get(0).getX());
                controleur.precY.set(fig.getPoints().get(0).getY());
                for(Point point : fig.getPoints()) {
                	controleur.trace(controleur.precX.get(), controleur.precY.get(), point.getX(), point.getY());
                    controleur.precX.set(point.getX());
                    controleur.precY.set(point.getY());;

                }

            }

        });
    	canvas.heightProperty().addListener((obs, nouvelle, ancienne)->{
    		
            for(Figure fig : controleur.dessin.getFigures()) {
                controleur.precX.set(fig.getPoints().get(0).getX());
                controleur.precY.set(fig.getPoints().get(0).getY());
                for(Point point : fig.getPoints()) {
                    controleur.trace(controleur.precX.get(), controleur.precY.get(), point.getX(), point.getY());
                    controleur.precX.set(point.getX());
                    controleur.precY.set(point.getY());

                }

            }

        });
	}
	public void setDessinControleur(Controleur ctl) {
		this.controleur = ctl;
	}
	
	public void efface() {
		canvas.addEventHandler(MouseEvent.MOUSE_CLICKED, event ->{
			canvas.getGraphicsContext2D().clearRect(event.getX(), event.getY(),event.getX(),event.getY());
		});
	}
	
	public void trace(int x1, int y1, int x2, int y2 ) {
		canvas.getGraphicsContext2D().strokeLine(x1, y1, x2, y2);
	}
	
	public void onMousePress(MouseEvent event) {
		controleur.outil.onMousePress(event);
	}
	
	public void onMouseMove(MouseEvent event) {
		controleur.onMouseMove(event);
	}
	
	public void onMouseDrag(MouseEvent event) {
		this.controleur.outil.onMouseDrag(event);
	}
	public void setEpaisseur(int epaisseur) {
		canvas.getGraphicsContext2D().setLineWidth(epaisseur);
	}
	public void setCouleur(Paint couleur) {
		canvas.getGraphicsContext2D().setStroke(couleur);
	}
}
