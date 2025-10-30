package iut.gon.sae.game.model.Fight;

import java.util.*;

import iut.gon.sae.game.Entity.Entity;
import iut.gon.sae.game.Entity.Player;

/**
 * 
 */
public class ManaGain extends Spell {

    /**
     * Default constructor
     */
    public ManaGain(int duration, int nbTurnLeft, int amount, int cost) {
    	super(duration);
    	this.amount = amount;
    	this.cost = cost;
    	this.nbTurnLeft = nbTurnLeft;
    }
    
    
    
    //applique les effets du sort sur l'entité
	@Override
	public void applyEffect(Entity on) {
		if(apply(on) == true && on.getClass().equals(Player.class) && ((Player) on).getCurrentMana() >0) {
			int hp = ((Player) on).getCurrentMana();
			((Player) on).setCurrentMana( hp + amount);
		}
		
	}
	
	//returne vrai si l'entité est le joueur
	@Override
	public boolean isSelfSpell() {
			return true;
	}

}