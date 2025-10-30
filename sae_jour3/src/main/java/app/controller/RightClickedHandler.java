package app.controller;

import java.util.HashMap;
import java.util.Map;

import app.model.map.Path;
import app.model.map.Place;
import app.model.map.World;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Line;

public class RightClickedHandler implements CenterMouseEvent {

	private Pane MainPane;

	private Map<Place, GraphicPlace> graphicPlaces;

	private World world;

	private CenterController controller;

	private GraphicPlace startPlace;

	private Line tempLine;


	public RightClickedHandler(Pane panel, Map<Place, GraphicPlace> graphicPlaces, World world, CenterController controller) {
	    this.MainPane = panel;
	    this.graphicPlaces = graphicPlaces;
	    this.world = world;
	    this.controller = controller;
	}

	@Override

	public void mousePressed(MouseEvent e) {

		for (GraphicPlace gp : graphicPlaces.values()) {

			if (gp.contains(gp.sceneToLocal(e.getSceneX(), e.getSceneY()))) {

				startPlace = gp;

				tempLine = new Line();

				tempLine.setStartX(e.getX());

				tempLine.setStartY(e.getY());

				tempLine.setEndX(e.getX());

				tempLine.setEndY(e.getY());

				MainPane.getChildren().add(tempLine);

				break;

			}

		}

	}

	@Override

	public void mouseDragged(MouseEvent e) {

		if (tempLine != null) {

			tempLine.setEndX(e.getX());

			tempLine.setEndY(e.getY());

		}

	}

	@Override

	public void mouseReleased(MouseEvent e) {

		if (tempLine != null) {

			for (GraphicPlace gp : graphicPlaces.values()) {

				if (gp != startPlace && gp.contains(gp.sceneToLocal(e.getSceneX(), e.getSceneY()))) {

					Place origin = startPlace.getPlace();

					Place destination = gp.getPlace();

					Path path = new Path(origin, destination, 1);

					World world = controller.getWorld();

					if (world == null || origin == null || destination == null)
						return;

					boolean pathExists = world.getPaths().stream().anyMatch(p ->

					(p.getFirstPlace().equals(origin) && p.getSecondPlace().equals(destination)) ||

							(p.getFirstPlace().equals(destination) && p.getSecondPlace().equals(origin))

					);

					if (pathExists) {

						System.out.println(" Le chemin entre " + origin.getName() + " et " + destination.getName()
								+ " existe déjà.");

						return;

					}

					path = new Path(origin, destination, 1);

					controller.addGraphicPath(path);

					break;

				}

			}

			MainPane.getChildren().remove(tempLine);

			tempLine = null;

			startPlace = null;

		}

	}

}
