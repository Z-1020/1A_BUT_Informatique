package iut.gon.Gribouille.controleurs;

import iut.gon.Gribouille.modele.Etoile;
import javafx.scene.input.MouseEvent;

public class OutilEtoile extends Outil {
	Etoile etoile;
	
	public OutilEtoile(Controleur controleur) {
		super(controleur);
	}
	
	public void onMousePress(MouseEvent event) {
		this.etoile = new Etoile(1,"black", event.getX(), event.getY());
	}
	
	public void onMouseDrag(MouseEvent event) {
		
	}
	

}
