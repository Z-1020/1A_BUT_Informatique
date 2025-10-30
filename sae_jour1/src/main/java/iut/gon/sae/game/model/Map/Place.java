package iut.gon.sae.game.model.Map;

import java.util.*;

import iut.gon.sae.game.Entity.*;

/**
 * 
 */
public class Place {
	private int id;
    private String name;
    private Monster monster;
    private String description;
    public boolean isEnd;
    private boolean isStart;
    private boolean isDefeat;
    protected ArrayList<Place> adjacentsPlaces = new ArrayList<Place>();
    protected HashMap<Path, Place> paths;
    /**
     * Default constructor
     */
    public Place(int id, String name, String description, boolean isStart, boolean isDefeat) {
    	this.id = id;
    	this.name = name;
    	this.description = description;
    	this.isStart = isStart;
    	this.isDefeat = isDefeat;
    }
    

    public void PlaceWithMonster(int id, String name, Monster monster, String description, boolean isEnd, boolean isStart, boolean isDefeat) {

    	this.id = id;
    	this.name = name;
    	this.monster = monster;
    	this.description = description;
    	this.isEnd = isEnd;
    	this.isStart = isStart;
    	this.isDefeat = isDefeat;
    }

    
    
    
    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public boolean hasThisName(String name) {
		if (this.name==name) {
			return true;
		}
		else return false;
	}
	
	public boolean hasThisId(int id) {
		if (this.id==id) {        
			return true;
		}
		else return false;
	}

	/**
     * @return
     */
    public List<Place> getAdjacentsPlace() {
    	Place[] arr= (Place[]) this.adjacentsPlaces.toArray();
    	List<Place> lis = Arrays.asList(arr);
    	return lis;
    }
    

    /**
     * @return
     */
    public HashMap<Path, Place> getPaths() {
    	return paths;
    }

}