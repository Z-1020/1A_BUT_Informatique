package app.controller;

import app.model.entity.Player;
import app.model.map.Path;
import app.model.map.Place;
import app.model.map.World;
import app.ai.world.WorldAnalyzer;
import app.ai.world.WorldGenerator;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.application.Platform;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.util.Duration;

import javafx.util.Pair;

import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.ResourceBundle;
import java.util.concurrent.CompletableFuture;

public class MainController implements Initializable{
	@FXML public GaucheController  menuGenerationController;
    @FXML public DroiteController menuDijkstraController;
    @FXML public HauteController menuSauvergardeController;
    @FXML public CenterController affichageDijkstraController;
    private MainController mainController;
    
    
   
    
	public void setMainController(MainController maincontrller) {
		this.mainController = maincontrller;
	}
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
	    menuDijkstraController.setDroitController(this);
	    menuGenerationController.setGaucheController(this);
	    menuSauvergardeController.setHauteController(this);
	    affichageDijkstraController.setCentreController(this);
	}
	
	public void addDijkstraListener(DijkstraEventListener listener) {
	    dijkstraListeners.add(listener);
	}
	
	
	public void launchDijkstra() {
	    Place start = selectedPlace.get();
	    if (start == null) return;

	    isDijkstraRunning.set(true);

	    CompletableFuture
	        .supplyAsync(() -> {
	            WorldAnalyzer analyzer = new WorldAnalyzer(currentWorld.get());
	            return analyzer.dijkstraWithSteps(start);
	        })
	        .thenAccept(steps -> Platform.runLater(() -> {
	            for (DijkstraEventListener listener : dijkstraListeners) {
	                listener.setup(start);
	            }
	            Timeline timeline = new Timeline();
	            Duration interval = Duration.millis(250);
	            Duration time = Duration.ZERO;

	            for (Pair<Place, HashMap<Place, Integer>> step : steps) {
	                Place from = step.getKey();
	                HashMap<Place, Integer> distances = step.getValue();

	                 timeline.getKeyFrames().add(new KeyFrame(time, e -> {
	                    for (DijkstraEventListener listener : dijkstraListeners) {
	                        listener.beforeLineFrom(from);
	                    }
	                }));
	                 time = time.add(interval);

	                for (Map.Entry<Place, Integer> entry : distances.entrySet()) {
	                    Place to = entry.getKey();
	                    int distance = entry.getValue();

	                    timeline.getKeyFrames().add(new KeyFrame(time, e -> {
	                        for (DijkstraEventListener listener : dijkstraListeners) {
	                            listener.beforeNewDistance(from, to);
	                        }
	                    }));
	                    time = time.add(interval);

	                    timeline.getKeyFrames().add(new KeyFrame(time, e -> {
	                        for (DijkstraEventListener listener : dijkstraListeners) {
	                            listener.newDistance(from, to, distance);
	                        }
	                    }));
	                    time = time.add(interval);

	                    timeline.getKeyFrames().add(new KeyFrame(time, e -> {
	                        for (DijkstraEventListener listener : dijkstraListeners) {
	                            listener.afterNewDistance(from, to);
	                        }
	                    }));
	                    time = time.add(interval);
	                }

	                timeline.getKeyFrames().add(new KeyFrame(time, e -> {
	                    for (DijkstraEventListener listener : dijkstraListeners) {
	                        listener.afterLineFrom(from);
	                    }
	                }));
	                time = time.add(interval);
	            }

	            timeline.getKeyFrames().add(new KeyFrame(time, e -> {
	                isDijkstraRunning.set(false);
	                for (DijkstraEventListener listener : dijkstraListeners) {
	                    listener.tearDown();
	                }
	            }));

	            timeline.play();
	        }));
	}



	public  ObjectProperty<Place> selectedPlace = new SimpleObjectProperty<>();
	private  ObjectProperty<World> currentWorld = new SimpleObjectProperty<>();
	private  BooleanProperty isDijkstraRunning = new SimpleBooleanProperty(false);
	private  BooleanProperty isGenerationRunning = new SimpleBooleanProperty(false);
	private  List<DijkstraEventListener> dijkstraListeners = new ArrayList<>();
	
	private ObjectProperty<World> world = new SimpleObjectProperty<>();

	public ObjectProperty<World> worldProperty() {
	    return world;
	}

	public void setWorld(World world) {
	    this.world.set(world);
	}


	
	public void generateAndLoadWorld() {
	    WorldGenerator generator = WorldGenerator.builder()
	            .name("Mon Monde")
	            .nbPlace(20)
	            .player(new Player())
	            .percentageStartPoint(0.1)
	            .percentageEndPoint(0.1)
	            .percentageDefeatPoint(0.1)
	            .percentageMonster(0.5)
	            .withAIGeneration(false)
	            .build();
	    World generatedWorld = generator.generate(p -> {
	        System.out.println("Texte généré pour : " + p.getName());
	    });
	    loadWorld(generatedWorld);
	}
	
	public void loadWorld(World world) {
		this.world.set(world);


	    affichageDijkstraController.clear();
	    for (Place p : world.getPlaces()) {
	        affichageDijkstraController.addPlace(p);
	    }
	    for (Path p : world.getPaths()) {
	        affichageDijkstraController.addPath(p);
	    }
	}
	
	public World getWorld() {
	    return world.get();
	}


	public BooleanProperty getIsDijkstraRunning() {
		return isDijkstraRunning;
	}
	
	public ObjectProperty<World> getCurrentWorld() {
		return currentWorld;
		
	}

}
