package fr.iutgon.tp6;

import fr.iutgon.tp6.modele.FabriqueProduits;
import fr.iutgon.tp6.modele.Ligne;
import fr.iutgon.tp6.modele.Produit;
import javafx.beans.binding.Bindings;
import javafx.beans.binding.NumberExpression;
import javafx.beans.property.ReadOnlyIntegerWrapper;
import javafx.beans.property.SimpleFloatProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.css.PseudoClass;
import javafx.event.ActionEvent;
import javafx.fxml.Initializable;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.control.cell.ChoiceBoxTableCell;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.util.Callback;
import javafx.util.StringConverter;
import javafx.util.converter.CharacterStringConverter;
import javafx.util.converter.IntegerStringConverter;

import java.net.URL;
import java.util.Random;
import java.util.ResourceBundle;

public class FactureController implements Initializable {
  public TableView<Ligne> table;
  public TableColumn<Ligne, Integer> qte;
  public TableColumn<Ligne, Produit> produit;
  public TableColumn<Ligne, Number> prixUnitaire;
  public TableColumn<Ligne, Number> totalHT;
  public TableColumn<Ligne, Number> totalTTC;
  public TextField sommeFacture;
  public TextField quantite;
  public Ligne ligne;


  /**
   Called to initialize a controller after its root element has been completely processed.

   @param location  The location used to resolve relative paths for the root object, or
   {@code null} if the location is not known.
   @param resources The resources used to localize the root object, or {@code null} if
   */
  @Override
  public void initialize(URL location, ResourceBundle resources) {
    //TODO préparer la table
  }

  public void onAjouter(ActionEvent actionEvent) {
    //TODO ajouter un produit aléatoire à la table
	  Random qte = new Random(100);
	  ligne = new Ligne(qte.nextInt(0,100), FabriqueProduits.getProduits().get(0));
	  table.getItems().add(ligne);
	  this.qte.setCellValueFactory(new PropertyValueFactory<>("qte"));
	  this.produit.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<Ligne,Produit>, ObservableValue<Produit>>() {
		
		@Override
		public ObservableValue<Produit> call(CellDataFeatures<Ligne, Produit> param) {
			// TODO Auto-generated method stub
			return param.getValue().produitProperty();
		}
	});
	  this.prixUnitaire.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<Ligne,Number>, ObservableValue<Number>>() {
			
			@Override
			public ObservableValue<Number> call(CellDataFeatures<Ligne,Number> param) {
				// TODO Auto-generated method stub
				return param.getValue().produitProperty().getValue().prixProperty();
			}
		});
	  this.totalHT.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<Ligne,Number>, ObservableValue<Number>>() {
			
			@Override
			public ObservableValue<Number> call(CellDataFeatures<Ligne,Number> param) {
				// TODO Auto-generated method stub
				return param.getValue().totalHTProperty();
			}
		});
	  this.totalTTC.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<Ligne,Number>, ObservableValue<Number>>() {
			
			@Override
			public ObservableValue<Number> call(CellDataFeatures<Ligne,Number> param) {
				// TODO Auto-generated method stub
				return param.getValue().totalTTCProperty();
			}
		});
	   this.qte.setCellFactory(TextFieldTableCell.forTableColumn(new IntegerStringConverter()));
	   this.produit.setCellFactory((cell) -> new ChoiceBoxTableCell<>(new StringConverter<Produit>() {
		   
		   
		   
		@Override
		public String toString(Produit object) {
			return ligne.getProduit().getNom() ;
		}

		@Override
		public Produit fromString(String string) {
			return ligne.getProduit();
		}
		   
	   }));
	   this.sommeFacture.textProperty().bind(ligne.totalTTCProperty().asString());
  }
  
}
