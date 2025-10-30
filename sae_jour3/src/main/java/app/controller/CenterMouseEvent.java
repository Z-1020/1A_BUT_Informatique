package app.controller;

import javafx.scene.input.MouseEvent;

public interface CenterMouseEvent {
	void mousePressed(MouseEvent event);
    void mouseDragged(MouseEvent event);
    void mouseReleased(MouseEvent event);
}
