package iut.gon.sae.game.model.Fight;

import java.util.*;

import iut.gon.sae.game.Entity.Entity;
import iut.gon.sae.game.Entity.Player;

/**
 * 
 */
public class Shield extends Spell {

    /**
     * Default constructor
     */
    public Shield(int duration, int nbTurnLeft, int amount, int cost) {
    	super(duration);
    	
    	this.amount = amount;
    	this.cost = cost;
    	this.nbTurnLeft = nbTurnLeft;
    }
    
    public boolean apply(Entity entity) {
    	if(entity != null) {
    		nbTurnLeft --;
    		return true;
    	}
    	return false;
    }
    
    
    //applique les effets du sort sur l'entité
	@Override
	public void applyEffect(Entity on) {
		if(apply(on) == true && ((Player) on).getCurrentMana() >0) {
			int attack =on.getArmor();
			on.setArmor(attack +amount);
			this.cost = this.cost+1;
		}
		
	}
	
	//returne vrai si l'entité est le joueur
	@Override
	public boolean isSelfSpell() {
			return true;
	}
}