package iut.gon.sae.game.model.Fight;

import java.util.*;

import iut.gon.sae.game.Entity.Entity;

/**
 * 
 */
public abstract class Spell {

  
	/*constructeur de la classe spell*/
	
    public Spell(int duration) {
		this.duration = duration;
    }

    /**
     * 
     */
    protected final int  duration;

    /**
     * 
     */
    protected int nbTurnLeft;

    public int getNbTurnLeft() {
		return nbTurnLeft;
	}

	public void setNbTurnLeft(int nbTurnLeft) {
		this.nbTurnLeft = nbTurnLeft;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public int getDuration() {
		return duration;
	}

	/**
     * 
     */
    protected int amount;

    /**
     * 
     */
    protected int cost;

    /**
     * @param on 
     * @return
     */
    
    /*
     *  vérifie que l'entité peut subir un sort
     */
    public boolean apply(Entity entity) {
    	if(entity != null) {
    		if(entity.isAlive() && nbTurnLeft >0) {
    			nbTurnLeft = nbTurnLeft - 1;
        		return true;
    		}
    	}
    	return false;
    }

    /**
     * applique les effects du sort sur l'entité
     */
    public abstract void applyEffect(Entity on);

    /**
     * retourne vrai si le sort s'applique sur le joueur 
     */
    public abstract boolean isSelfSpell();
    
    

}