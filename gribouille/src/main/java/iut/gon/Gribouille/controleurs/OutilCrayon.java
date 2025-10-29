package iut.gon.Gribouille.controleurs;

import iut.gon.Gribouille.modele.Trace;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;

public class OutilCrayon extends Outil{

	public OutilCrayon(Controleur controleur) {
		super(controleur);
		// TODO Auto-generated constructor stub
	}
	public void onMousePress(MouseEvent event) {
		controleur.precX.set(event.getX());
		controleur.precY.set(event.getY());
		controleur.figure = new Trace(controleur.epaisseur.get(),controleur.couleur.toString(), event.getX(), event.getY());
		controleur.dessin.addFigure(controleur.figure);
	}
	
	public void onMouseDrag(MouseEvent event) {
		if(event.getX() >=0 && event.getX()<=controleur.dessinController.pane.getWidth() && event.getY() >=0 && event.getY()<=controleur.dessinController.pane.getHeight() ) {
			controleur.trace(controleur.precX.doubleValue(), controleur.precY.doubleValue(), event.getX(), event.getY());
			controleur.figure.addPoint(event.getX(), event.getY());
			controleur.dessine(event);
			}
	}
	
}
