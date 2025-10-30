package iut.gon.sae.game.model.Map;

import java.util.*;

import iut.gon.sae.game.Entity.*;

/**
 * 
 */
public class World {
	private String name;
	public HashMap<Place, HashMap<Path ,Place>> cache = new HashMap<Place, HashMap<Path ,Place>>();
	 
    public World(String name) {
    	this.name = name;
    }
    

    public void addPlace(Place place) {
    	cache.put(place, null);
    }

 
    public void addPath(Path path) throws UnknowPlaceException{
    	if(path.firstPlace != null && path.secondPlace != null ) {
    		HashMap<Path,Place> innerMap = new HashMap<Path, Place>();
    		innerMap.put(path, path.secondPlace);
    		cache.putIfAbsent(path.firstPlace, innerMap);
    		path.firstPlace.adjacentsPlaces.add(path.secondPlace);
    		path.firstPlace.paths.put(path, path.secondPlace);
    		path.secondPlace.adjacentsPlaces.add(path.firstPlace);
    		path.secondPlace.paths.put(path, path.firstPlace);
    	}
    	else {
    		throw new UnknowPlaceException("place inconnue");
    	}
    	
    }

    /**
     * @param name
     */
    public Place getPlaceFromName(String name) {
    	for ( Place place : cache.keySet()) {
    		if(place.hasThisName(name)) {
    			return place;
    		}
    	}
    	return null;
    }

    /**
     * @param id
     */
    public Place getPlaceFromId(int id) {
    	for ( Place place : cache.keySet()) {
    		if(place.hasThisId(id)) {
    			return place;
    		}
    	}
    	return null;

    }

    /**
     * @param place 
     * @return
     */
    public HashMap<Path, Place> getPathsFrom(Place place) {
    	return cache.get(place);
    }
    
    public String toString() {
    	return "{\n\"world\": \""+name+"\",\n\"places\": ["+"]\n}";
    }


}