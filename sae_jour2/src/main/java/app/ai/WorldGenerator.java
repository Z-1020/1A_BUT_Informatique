package app.ai;

import app.model.entity.Monster;
import app.model.entity.Player;
import app.model.map.*;
import app.model.exceptions.InsuffisantNumberOfPlacesException;
import app.model.exceptions.UnknownPlaceException;

import java.util.*;

public class WorldGenerator {

    public static World createWorld(String name, int nbPlace, Player player, float percentageEndPoint, float percentageStartPoint, float percentageDefeatPoint, float percentageCoverage) throws InsuffisantNumberOfPlacesException {

        if (nbPlace < 2) {
            throw new InsuffisantNumberOfPlacesException("Le monde doit contenir au moins 2 lieux.");
        }

        float totalPercentage = percentageEndPoint + percentageStartPoint + percentageDefeatPoint;
        if (percentageEndPoint < 0 || percentageStartPoint < 0 || percentageDefeatPoint < 0 
        		|| percentageEndPoint > 1 || percentageStartPoint > 1 || percentageDefeatPoint > 1 || totalPercentage > 1) {
            throw new IllegalArgumentException("Les pourcentages ne sont pas correct.");
        }

        int nbPlaceEnd = Math.round(nbPlace * percentageEndPoint);
        int nbPlaceStart = Math.round(nbPlace * percentageStartPoint);
        int nbPlaceDefeat = Math.round(nbPlace * percentageDefeatPoint);
        int nbPlaceNormal = nbPlace - nbPlaceEnd - nbPlaceStart - nbPlaceDefeat;

        Random rand = new Random();
        API api = new API();
        World world = new World(API.nom);
        List<Place> allPlaces = new ArrayList<>();

        int id = 0;
        for (int i = 0; i < nbPlaceStart; i++) {
        	API api1 = new API();
            allPlaces.add(new Place(id++, api1.nom, null, api1.desc, world, true, false, false));
        }
        for (int i = 0; i < nbPlaceEnd; i++) {
        	API api1 = new API();
            allPlaces.add(new Place(id++, api1.nom, null, api1.desc, world, false, true, false));
        }
        for (int i = 0; i < nbPlaceDefeat; i++) {
        	API api1 = new API();
            allPlaces.add(new Place(id++, api1.nom, null, api1.desc, world, false, false, true));
        }
        for (int i = 0; i < nbPlaceNormal; i++) {
        	API api1 = new API();
            allPlaces.add(new Place(id++, api1.nom, null, api1.desc, world, false, false, false));
        }

        for (Place p : allPlaces) {
            world.addPlace(p);
        }
        

        // connexion aléatoire des paths en fonction du coverage
        int taille = allPlaces.size();
        int nbrConnection = Math.round((taille * (taille - 1)) / 2 * percentageCoverage);

        Set<String> existingConnections = new HashSet<>();
        int addedConnections = 0;


        while (addedConnections < nbrConnection) {
            Place a = allPlaces.get(rand.nextInt(taille));
            Place b = allPlaces.get(rand.nextInt(taille));
            if (a == b) continue;

            String key = a.getId() < b.getId() ? a.getId() + "-" + b.getId() : b.getId() + "-" + a.getId();
            if (existingConnections.contains(key)) continue;

            try {
                world.addPath(new Path(rand.nextInt(2) + 1, a, b));
                existingConnections.add(key);
                addedConnections++;
            } catch (UnknownPlaceException e) {
                e.printStackTrace();
            }
        }

        for (int i = 1; i < taille; i++) {
            Place a = allPlaces.get(i - 1);
            Place b = allPlaces.get(i);
            String key = a.getId() < b.getId() ? a.getId() + "-" + b.getId() : b.getId() + "-" + a.getId();
            if (!existingConnections.contains(key)) {
                try {
                    world.addPath(new Path(rand.nextInt(9) + 1, a, b));
                    existingConnections.add(key);
                } catch (UnknownPlaceException e) {
                    e.printStackTrace();
                }
            }
        }

        
        // test pour savoir si le monde est bien connexe
        WorldAnalyzer analyzer = new WorldAnalyzer(world);
        if (!analyzer.isConnexe()) {
            throw new RuntimeException("Le monde généré n'est pas connexe.");
        }

        if (!analyzer.isFinishable()) {
            throw new RuntimeException("Le monde généré n'est pas finissable.");
        }

        return world;
    }
}
