package app.controller;

import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.ResourceBundle;

import app.model.map.Path;
import app.model.map.Place;
import app.model.map.World;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.input.MouseButton;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Pane;
import javafx.scene.shape.Line;

public class CenterController {
    
    @FXML
    private Pane MainPane;

    private MainController CentreController;

    private final HashMap<Place, GraphicPlace> placeToGraphic = new HashMap<>();
    private final HashMap<Path, GraphicPath> pathToGraphic = new HashMap<>();
    private World world;
    public void setCentreController(MainController mainController) {
        this.CentreController = mainController;
        CentreController.worldProperty().addListener((obs, oldWorld, newWorld) -> updateWorld(newWorld));
        this.world = mainController.getWorld();
        secondaryHandler = new RightClickedHandler(MainPane, getGraphicPlaces(), world, this);
        updateWorld(this.world);
        primaryHandler = new LeftClickedHandler(MainPane);
        
        MainPane.setOnMousePressed(e -> {
            if (e.getButton() == MouseButton.PRIMARY)
                primaryHandler.mousePressed(e);
            else if (e.getButton() == MouseButton.SECONDARY)
                secondaryHandler.mousePressed(e);
        });

        MainPane.setOnMouseDragged(e -> {
            if (e.getButton() == MouseButton.PRIMARY)
                primaryHandler.mouseDragged(e);
            else if (e.getButton() == MouseButton.SECONDARY)
                secondaryHandler.mouseDragged(e);
        });

        MainPane.setOnMouseReleased(e -> {
            if (e.getButton() == MouseButton.PRIMARY)
                primaryHandler.mouseReleased(e);
            else if (e.getButton() == MouseButton.SECONDARY)
                secondaryHandler.mouseReleased(e);
        });
        
        MainPane.setOnScroll(event -> {
            double zoomFactor = event.getDeltaY() < 0 ? 1 / 1.1 : 1.1;
            MainPane.setScaleX(MainPane.getScaleX() * zoomFactor);
            MainPane.setScaleY(MainPane.getScaleY() * zoomFactor);
            event.consume();
        });
    }
    private CenterMouseEvent primaryHandler;
    private CenterMouseEvent secondaryHandler;

   
    private void updateWorld(World world) {
        MainPane.getChildren().clear();
        placeToGraphic.clear();
        pathToGraphic.clear();

        if (world == null) return;

        Random random = new Random();
        for (Place place : world.getPlaces()) {
            double x = random.nextDouble(0, 500);
            double y = random.nextDouble(0, 500);
            GraphicPlace gp = new GraphicPlace(place, 10, x, y); 

            placeToGraphic.put(place, gp);
            MainPane.getChildren().addAll(gp, gp.getLabel());
        }

        for (Path path : world.getPaths()) {
            Place from = path.getFirstPlace();
            Place to = path.getSecondPlace();
            GraphicPath graphicPath = new GraphicPath(path, placeToGraphic.get(from), placeToGraphic.get(to));
            pathToGraphic.put(path, graphicPath);
            MainPane.getChildren().addAll(graphicPath, graphicPath.getLabel());
        }
    }

    public void addGraphicPath(Path path) {
    	world.addPath(path);
        GraphicPlace from = placeToGraphic.get(path.getFirstPlace());
        GraphicPlace to = placeToGraphic.get(path.getSecondPlace());

        if (from != null && to != null) {
            GraphicPath graphicPath = new GraphicPath(path, from, to);
            pathToGraphic.put(path, graphicPath);
            MainPane.getChildren().addAll(graphicPath, graphicPath.getLabel());
            graphicPath.toBack();
        }
        
    }

    public Pane getMainPane() {
        return MainPane;
    }

    public Map<Place, GraphicPlace> getGraphicPlaces() {
        return placeToGraphic;
    }

    public Map<Path, GraphicPath> getGraphicPaths() {
        return pathToGraphic;
    }

    public World getWorld() {
        return this.world;
    }

    public GraphicPlace findGraphicPlaceAt(double x, double y) {
        for (GraphicPlace gp : placeToGraphic.values()) {
            if (gp.contains(gp.sceneToLocal(x, y))) {
                return gp;
            }
        }
        return null;
    }

    public void clear() {
        MainPane.getChildren().clear();
        placeToGraphic.clear();
        pathToGraphic.clear();
    }
    public void addPlace(Place place) {
        double x = Math.random() * 500;
        double y = Math.random() * 500;
        GraphicPlace graphicPlace = new GraphicPlace(place, 10, x, y);

        placeToGraphic.put(place, graphicPlace);
        MainPane.getChildren().addAll(graphicPlace, graphicPlace.getLabel());
    }

	public void addPath(Path path) {
	    GraphicPlace from = placeToGraphic.get(path.getFirstPlace());
	    GraphicPlace to = placeToGraphic.get(path.getSecondPlace());
	    if (from == null || to == null) {
	        System.err.println("Les places du chemin n'existent pas graphiquement");
	        return;
	    }
	    GraphicPath graphicPath = new GraphicPath(path, from, to);
	    pathToGraphic.put(path, graphicPath);
	    MainPane.getChildren().addAll(graphicPath, graphicPath.getLabel());
	}


}
    

