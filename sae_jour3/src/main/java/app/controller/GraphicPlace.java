package app.controller;

import javafx.scene.control.Label;
import javafx.beans.binding.Bindings;
import app.model.map.Place;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;

public class GraphicPlace extends Circle {
	private final Place place;
	private final Label label;
    private final SimpleObjectProperty<GraphicPlaceState> state ;
    private final BooleanProperty selected ;

    public GraphicPlace(Place place, double radius, double x, double y) {
    	super(radius);
        this.place = place;
        this.label = new Label();
        this.state = new SimpleObjectProperty<>(GraphicPlaceState.IS_DEFAULT);
        this.selected = new SimpleBooleanProperty(false);
        setCenterX(x);
        setCenterY(y);
        label.layoutXProperty().bind(centerXProperty().add(radius));
        label.layoutYProperty().bind(centerYProperty().subtract(radius));
        fillProperty().bind(Bindings.createObjectBinding(() -> state.get().getColor(), state));	
        strokeWidthProperty().bind(
            Bindings.when(selected)
                .then(4.0)
                .otherwise(Bindings.createDoubleBinding(() -> state.get().getStrokeWidth(), state))
        );
        setStroke(Color.BLACK);
        label.textProperty().set(String.valueOf(place.getId()));
    }

	public Place getPlace() {
		return place;
	}

	public Label getLabel() {
		return label;
	}

	public SimpleObjectProperty<GraphicPlaceState> getState() {
		return state;
	}

	public BooleanProperty getSelected() {
		return selected;
	}

}
