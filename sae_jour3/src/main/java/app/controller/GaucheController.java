package app.controller;

import javafx.scene.control.*;
import java.net.URL;
import java.util.Observable;
import java.util.ResourceBundle;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicIntegerFieldUpdater;

import app.ai.world.WorldGenerator;
import javafx.application.Platform;
import javafx.beans.property.IntegerProperty;
import javafx.beans.value.ChangeListener;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Label;
import javafx.scene.control.Slider;
import javafx.scene.control.TextField;
import javafx.scene.layout.Background;

public class GaucheController implements Initializable  {
	private MainController gauchecontroller;
	private int nbTotalPlace = 10;
	@FXML
	private TextField textFieldNomMonde;
	@FXML
	private TextField textFieldNbPlaces;
	@FXML
	private Slider sliderDebut;
	@FXML
	private Label labelNbDebut;
	@FXML
	private Slider sliderVictoire;
	@FXML
	private Label labelNbVictoire;
	
	@FXML
	private Slider sliderDefaite;
	@FXML
	private Label labelNbDefaite;
	
	@FXML
	private Slider sliderAutre;
	@FXML
	private Label labelNbAutre;
	
	@FXML
	private Slider sliderCouverture;
	@FXML
	private Label labelNbCouverture;
	@FXML
	private CheckBox checkBoxIA;
	@FXML
	private Button buttonGenMonde;
	@FXML
	private Slider sliderMonstre;
	@FXML
	private Label labelNbMonstre;
	
	@FXML
	private ProgressBar progressBar;
	private int nbPlace = 0;
	
	public void setGaucheController(MainController controller) {
		this.gauchecontroller = controller;
	}

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		textFieldNbPlaces.textProperty().addListener((observable,oldValue,newValue) ->{
			//verifier si le texte contient uniquement les chiffre
			if (!newValue.matches("\\d*")) {
				//sinon on revient a l'ancinne valeur 
				textFieldNbPlaces.setText(oldValue);
			}
			updateButtonState();
		});
		
		Runnable update = ( )->{
			int debut = (int)sliderDebut.getValue();
			int deafite = (int)sliderDefaite.getValue();
			int victoire = (int)sliderVictoire.getValue();
			int autre = (int)sliderAutre.getValue();
			int monstre = (int)sliderMonstre.getValue();
			int couverture = (int) Math.round(sliderCouverture.getValue());
			int SliderSomme = deafite + debut + victoire;
			sliderAutre.setDisable(true);
			
			if(SliderSomme <= 100 ) {
				int val = 100 - SliderSomme;
				sliderAutre.setValue(val);
				
				sliderDebut.setStyle("");
				sliderDefaite.setStyle("");
				sliderVictoire.setStyle("");
			}else {
				sliderAutre.setValue(0);
				String rouge = "-fx-control-inner-background: #ffcccc";
				sliderDebut.setStyle(rouge);
				sliderDefaite.setStyle(rouge);
				sliderVictoire.setStyle(rouge);
			}
			
			labelNbDebut.setText(debut+"% ("+ (debut*nbTotalPlace)/100+")");
			labelNbDefaite.setText(deafite+"% ("+(deafite*nbTotalPlace)/100+")");
			labelNbVictoire.setText(victoire+"% ("+(victoire*nbTotalPlace)/100+")");
			labelNbAutre.setText(autre+"% ("+(autre*nbTotalPlace)/100+")");
			
			
			try {nbPlace  = Integer.parseInt(textFieldNbPlaces.getText());
				nbTotalPlace = nbPlace;
			}catch (Exception e) {}
			double nbTotalChemins = (nbPlace * (nbPlace -1))/2;
			labelNbCouverture.setText(couverture+"% (="+nbTotalChemins+")");
			int nbPlaceAvecMonstre = (nbPlace * monstre)/100;
			labelNbMonstre.setText(monstre+"% (="+nbPlaceAvecMonstre+")");
			
			updateButtonState();
		};
		ChangeListener<Number> listener = (obs,oldValue,newValue)-> {
			updateButtonState();
			update.run();
		}; 
		sliderDebut.valueProperty().addListener(listener);
		sliderDefaite.valueProperty().addListener(listener);
		sliderVictoire.valueProperty().addListener(listener);
		sliderCouverture.valueProperty().addListener(listener);
		sliderMonstre.valueProperty().addListener(listener);
		
		
		
	}
	
	private void updateButtonState() {
	    int somme = (int)(sliderDebut.getValue() + sliderDefaite.getValue() + sliderVictoire.getValue());
	    try {
	        int nb = Integer.parseInt(textFieldNbPlaces.getText());
	        buttonGenMonde.setDisable(nb <= 2 || somme > 100);
	    } catch (NumberFormatException e) {
	        buttonGenMonde.setDisable(true);
	    }
	}
	@FXML
	private void onGenererMonde() {
	    String nomMonde = textFieldNomMonde.getText();
	    int nbPlaces = Integer.parseInt(textFieldNbPlaces.getText());
	    float pourcentageDepart = (float) sliderDebut.getValue() / 100;
	    float pourcentageDefaite = (float) sliderDefaite.getValue() / 100;
	    float pourcentageVictoire = (float) sliderVictoire.getValue() / 100;
	    boolean withAI = checkBoxIA.isSelected();

	    // Reset de la ProgressBar
	    if (withAI) {
	        progressBar.setProgress(0);
	        progressBar.setVisible(true);
	    } else {
	        progressBar.setVisible(false);
	    }

	    // Lancer dans un thread secondaire
	    CompletableFuture.runAsync(() -> {
	        AtomicInteger compteur = new AtomicInteger(0);

	        WorldGenerator.builder()
	            .name(nomMonde)
	            .nbPlace(nbPlaces)
	            .percentageStartPoint(pourcentageDepart)
	            .percentageDefeatPoint(pourcentageDefaite)
	            .withAIGeneration(withAI)
	            .build()
	            .generate(place -> {
	                int count = compteur.incrementAndGet();

	                if (withAI) {
	                    double progress = (double) count / nbPlaces;

	                    //Mise à jour UI via Platform.runLater
	                    Platform.runLater(() -> {
	                        progressBar.setProgress(progress);
	                    });
	                }
	            });

	        // Une fois fini : on peut cacher ou bloquer la ProgressBar
	        if (withAI) {
	            Platform.runLater(() -> {
	                progressBar.setProgress(1.0);
	            });
	        }
	    });
	}
	
	

}
