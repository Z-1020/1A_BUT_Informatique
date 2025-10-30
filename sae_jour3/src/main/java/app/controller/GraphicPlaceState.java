package app.controller;

import javafx.scene.paint.Color;

public enum GraphicPlaceState {
	IS_DEFAULT(Color.LIGHTGRAY, 2.0),
    IS_END(Color.RED, 2.0),
    IS_START(Color.GREEN, 2.0),
    IS_DEFEAT(Color.BLACK, 2.0),
    DIJKSTRA_OVER(Color.DEEPSKYBLUE, 2.0),
    DIJKSTRA_VISITED(Color.YELLOW, 2.0),
    DIJKSTRA_UNVISITED(Color.GRAY, .0),
    DIJKSTRA_CURRENT(Color.ORANGE, 2.0),
    DIJKSTRA_MODIFIED(Color.PURPLE, 2.0);

    private final Color color;
    private final double strokeWidth;

    GraphicPlaceState(Color color, double strokeWidth) {
        this.color = color;
        this.strokeWidth = strokeWidth;
    }

    public Color getColor() {
        return color;
    }

    public double getStrokeWidth() {
        return strokeWidth;
    }
}
