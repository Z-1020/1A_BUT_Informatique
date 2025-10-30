package iut.gon.sae.game.model.Fight;

import java.util.*;

import iut.gon.sae.game.Entity.Entity;
import iut.gon.sae.game.Entity.Monster;
import iut.gon.sae.game.Entity.Player;

/**
 * 
 */
public class Poison extends Spell {

    /**
     * Default constructor
     */
    public Poison(int duration, int nbTurnLeft, int amount, int cost) {
    	super(duration);
    	
    	this.amount = amount;
    	this.cost = cost;
    	this.nbTurnLeft = nbTurnLeft;
    }
    
    
    //applique les effets du sort sur l'entité
	@Override
	public void applyEffect(Entity on) {
		if(apply(on) == true ) {
			int hp =on.getCurrentHP();
			on.setCurrentHP( hp - amount);
		}
		
	}
	
	//returne vrai si l'entité est le joueur
	@Override
	public boolean isSelfSpell() {
			return false;
	}

}