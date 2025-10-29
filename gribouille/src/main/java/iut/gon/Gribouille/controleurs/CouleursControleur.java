package iut.gon.Gribouille.controleurs;

import java.net.URL;
import java.util.ResourceBundle;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ColorPicker;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.TilePane;
import javafx.scene.layout.VBox;
import javafx.scene.shape.Rectangle;

public class CouleursControleur implements Initializable{
	
	public Controleur controleur;
	@FXML
	public VBox couleur;
	@FXML
	public ColorPicker colorPicker;
	@FXML
	public Rectangle rectangle1;
	@FXML
	public Rectangle rectangle2;
	@FXML
	public Rectangle rectangle3;
	@FXML
	public Rectangle rectangle4;
	@FXML
	public Rectangle rectangle5;
	@FXML
	public Rectangle rectangle6;
	@FXML
	public Rectangle rectangle7;
	@FXML
	public Rectangle rectangle8;
	
	@FXML
	public  TilePane tilePane;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		couleur.addEventHandler(MouseEvent.MOUSE_CLICKED, event ->{
			if(event.getTarget().toString().contains("rectangle1")) {
				controleur.setCouleur(rectangle1.getFill());
				rectangle1.setArcWidth(10);
				rectangle1.setArcHeight(10);
				rectangle1.setStrokeWidth(5);
			}
			else if(event.getTarget().toString().contains("rectangle2")) {
				controleur.setCouleur(rectangle2.getFill());
				rectangle2.setArcWidth(10);
				rectangle2.setArcHeight(10);
				rectangle2.setStrokeWidth(5);
			}
			else if(event.getTarget().toString().contains("rectangle3")) {
				controleur.setCouleur(rectangle3.getFill());
				rectangle3.setArcWidth(10);
				rectangle3.setArcHeight(10);
				rectangle3.setStrokeWidth(5);
			}
			else if(event.getTarget().toString().contains("rectangle4")) {
				controleur.setCouleur(rectangle4.getFill());
				rectangle4.setArcWidth(10);
				rectangle4.setArcHeight(10);
				rectangle4.setStrokeWidth(5);
			}
			else if(event.getTarget().toString().contains("rectangle5")) {
				controleur.setCouleur(rectangle5.getFill());
				rectangle5.setArcWidth(10);
				rectangle5.setArcHeight(10);
				rectangle5.setStrokeWidth(5);
			}
			
			else if(event.getTarget().toString().contains("rectangle6")) {
				controleur.setCouleur(rectangle6.getFill());
				rectangle6.setArcWidth(10);
				rectangle6.setArcHeight(10);
				rectangle6.setStrokeWidth(5);
			}
			else if(event.getTarget().toString().contains("rectangle7")) {
				controleur.setCouleur(rectangle7.getFill());
				rectangle7.setArcWidth(10);
				rectangle7.setArcHeight(10);
				rectangle7.setStrokeWidth(5);
			}
			else if(event.getTarget().toString().contains("rectangle8")) {
				controleur.setCouleur(rectangle8.getFill());
				rectangle8.setArcWidth(10);
				rectangle8.setArcHeight(10);
				rectangle8.setStrokeWidth(5);
			}
			
		});
		
	}
	
	public void setCouleursControleur(Controleur ctl) {
		controleur = ctl;
	}
	
}
