package app.controller;

import app.model.map.Path;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.scene.control.Label;
import javafx.scene.shape.Line;
import javafx.scene.shape.StrokeLineCap;
import javafx.beans.binding.Bindings;

public class GraphicPath extends Line{
	private Path path;
	private  GraphicPlace from, to;
    private Label label;
    private ObjectProperty<GraphicPathState> state;

    public GraphicPath(Path path, GraphicPlace from, GraphicPlace to) {
        this.path = path;
        this.from = from;
        this.to = to;
        this.state = new SimpleObjectProperty<>(GraphicPathState.DEFAULT);
        startXProperty().bind(from.centerXProperty());
        startYProperty().bind(from.centerYProperty());
        endXProperty().bind(to.centerXProperty());
        endYProperty().bind(to.centerYProperty());

        strokeProperty().bind(Bindings.createObjectBinding(() -> state.get().getColor(), state));
        strokeWidthProperty().bind(Bindings.createObjectBinding(() -> state.get().getStrokeWidth(), state));
        setStrokeLineCap(StrokeLineCap.ROUND);

        toBack();
        label = new Label(String.valueOf(path.getLength()));
        label.textFillProperty().bind(strokeProperty());
        label.styleProperty().bind(Bindings.createStringBinding(
            () -> "-fx-font-weight: bold; -fx-stroke-width: " + state.get().getStrokeWidth() + ";",
            state
        ));
        label.layoutXProperty().bind(Bindings.createDoubleBinding(() ->
                (from.getCenterX() + to.getCenterX()) / 2, from.centerXProperty(), to.centerXProperty()));
        label.layoutYProperty().bind(Bindings.createDoubleBinding(() ->
                (from.getCenterY() + to.getCenterY()) / 2, from.centerYProperty(), to.centerYProperty()));
    }


    public Path getPath() {
        return path;
    }

    public GraphicPlace getFrom() {
        return from;
    }

    public GraphicPlace getTo() {
        return to;
    }

    public Label getLabel() {
        return label;
    }

    public ObjectProperty<GraphicPathState> stateProperty() {
        return state;
    }

    public GraphicPathState getState() {
        return state.get();
    }

    public void setState(GraphicPathState state) {
        this.state.set(state);
    }
	
	
}
