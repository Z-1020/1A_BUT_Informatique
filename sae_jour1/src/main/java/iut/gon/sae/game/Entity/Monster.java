package iut.gon.sae.game.Entity;

import java.util.*;

import iut.gon.sae.game.save.JSONObject;

/**
 * 
 */
public class Monster extends Entity {

    private String name;
    
   

    public Monster() {
    	super();
    	this.name="";
    }
    
    public Monster(int currentHP, int maximumHP, int armor, int attack, String name) {
    	super(currentHP, maximumHP, armor, attack);
    	this.name= name;
    }

    
    /* retourne le nom du monstre*/
    
    public String getName() {
		return name;
	}
    /* change le nom du monstre*/
    
	public void setName(String name) {
		this.name = name;
	}

	/**
     * @param json
     */
    public static void createMonsterFromJSON(JSONObject json) {
        // TODO implement here
    }

    /**
     * @return
     */
    public String asJSON() {
        // TODO implement here
        return "";
    }

}