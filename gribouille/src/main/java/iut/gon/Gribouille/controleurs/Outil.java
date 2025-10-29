package iut.gon.Gribouille.controleurs;

import javafx.scene.input.MouseEvent;

public abstract class Outil {
	
	protected Controleur controleur;
	
	public Outil(Controleur controleur) {
		this.controleur = controleur;
	}
	
	public void onMousePress(MouseEvent event) {}
	
	public void onMouseDrag(MouseEvent event) {}

}
