package app;

import app.ai.WorldGenerator;
import app.controller.Game;
import app.model.parser.WorldIO;
import app.model.entity.Player;
import app.model.exceptions.InsuffisantNumberOfPlacesException;
import app.model.map.World;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException, InsuffisantNumberOfPlacesException {
        //World world = WorldIO.loadWorld(Main.class.getResourceAsStream("Monde1.json"));
    	World world = WorldGenerator.createWorld("test", 10, new Player(), (float) 0.2, (float) 0.2, (float) 0.2, (float) 0.4);
        Player player = new Player(100,100,20,20, 100);
        Game game = new Game(world, player);

        game.play();
    }
}