	package app.controller;
	
	import javafx.scene.paint.Color;
	
	public enum GraphicPathState {
		DEFAULT(Color.LIGHTGRAY, 2.0),
		HAS_FOCUS(Color.ORANGE , 2.0),
		HAS_FOCUS_MODIFIED(Color.RED, 2.0);
		
		private final Color color;
	    private final double strokeWidth;
	    GraphicPathState(Color color, double strokeWidth) {
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
