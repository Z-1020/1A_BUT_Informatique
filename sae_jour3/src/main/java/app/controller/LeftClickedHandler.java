package app.controller;

import javafx.scene.Cursor;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.Pane;

public class LeftClickedHandler implements CenterMouseEvent {
    
    private Pane MainPane;
    private double startX, startY;
    private double lastTranslateX, lastTranslateY;

    public LeftClickedHandler(Pane pane) {
        this.MainPane = pane;
    }
    
    @Override
    public void mousePressed(MouseEvent e) {
        if (e.getTarget() != MainPane) return;
        startX = e.getSceneX();
        startY = e.getSceneY();
        lastTranslateX = MainPane.getTranslateX();
        lastTranslateY = MainPane.getTranslateY();
        MainPane.setCursor(Cursor.MOVE);
        
    }

    @Override
    public void mouseDragged(MouseEvent e) {
        double dx = e.getSceneX() - startX;
        double dy = e.getSceneY() - startY;
        MainPane.setTranslateX(lastTranslateX + dx);
        MainPane.setTranslateY(lastTranslateY + dy);
        
    }

    @Override
    public void mouseReleased(MouseEvent e) {
        MainPane.setCursor(Cursor.DEFAULT);
        
    }

}
