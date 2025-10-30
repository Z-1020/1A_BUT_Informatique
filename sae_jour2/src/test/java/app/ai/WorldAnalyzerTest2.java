package app.ai;

import app.ai.WorldAnalyzer;
import app.model.map.World;
import app.model.parser.WorldIO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class WorldAnalyzerTest2 {
    World w;
    WorldAnalyzer analyzer;


   @Test
   public void testConnexe() throws IOException {
	   w = WorldIO.loadWorld(Files.newInputStream(Paths.get("src/main/resources/app/MondeTest1.json")));
       analyzer = new WorldAnalyzer(w);
	   assertFalse(analyzer.isConnexe());
   }
   
   @Test 
   public void testFinishable() throws IOException {
	   w = WorldIO.loadWorld(Files.newInputStream(Paths.get("src/main/resources/app/Monde1.json")));
       analyzer = new WorldAnalyzer(w);
       
       assertTrue(analyzer.isFinishable());
   }
}
