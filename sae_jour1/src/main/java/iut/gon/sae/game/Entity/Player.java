package iut.gon.sae.game.Entity;

import java.util.List;

import iut.gon.sae.game.model.Fight.Spell;



/**
 * 
 */
public class Player extends Entity {

    private int currentMana;
    private int maximumMana;
    private List<Spell> spells;

    
    public Player() {
    	super();
    	currentMana = 0;
    	maximumMana = 0;
    	
    }
    
    public Player(int currentHP, int maximumHP, int armor, int attack, int currentMana, int maximumMana) {
    	super(currentHP, maximumHP, armor, attack);
    	if(currentMana>maximumMana)currentMana = maximumMana;
    	this.currentMana = currentMana; 
    	this.maximumMana = maximumMana;
    }
    

    public int getCurrentMana() {
		return currentMana;
	}



	public void setCurrentMana(int currentMana) {
		this.currentMana = currentMana;
	}



	public int getMaximumMana() {
		return maximumMana;
	}



	public void setMaximumMana(int maximumMana) {
		this.maximumMana = maximumMana;
	}



	public List<Spell> getSpells() {
		return spells;
	}



	public void setSpells(List<Spell> spells) {
		this.spells = spells;
	}



	/**
     * @param spell 
     * @param target
     */
    public void castSpell(Spell spell, Entity target) {
    	if(spell.isSelfSpell()) {
    		spell.apply(this);
    		spell.applyEffect(this);
    		currentMana = getCurrentMana() -spell.getCost();

    	}
    	else {
    		spell.apply(target);
    		spell.applyEffect(target);
    	}
    }

}