package app;

import app.controller.Game;
import app.controller.MainController;
import app.model.parser.WorldIO;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import app.model.entity.Player;
import app.model.map.World;

import java.io.IOException;
import java.io.InputStream;
import java.lang.ModuleLayer.Controller;

public class Main extends Application{
    public static void main(String[] args) throws IOException {
        launch(args);
    }
    
    @Override
    public void start(Stage primaryStage) throws Exception {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("main.fxml"));
        Scene scene = new Scene(loader.load());
        MainController controller = loader.getController();
        primaryStage.setScene(scene);
        primaryStage.setTitle("Visualisation Dijkstra");
        primaryStage.show();
    }
}