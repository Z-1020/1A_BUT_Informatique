package iut.gon.sae.game.Entity;

import java.util.*;

import iut.gon.sae.game.model.Fight.Spell;

/**
 * 
 */
public abstract class Entity {

  
    protected int currentHP;
    protected int maximumHP;
    protected int armor;
    protected int attack;
    protected List<Spell> effect;

    
    public Entity() {
    	currentHP = 100;
    	maximumHP = 100;
    	armor = 10;
    	attack = 10;
    }
    
    public Entity(int currentHP, int maximumHP, int armor, int attack) {
    	if(currentHP>maximumHP)currentHP = maximumHP;
    	this.currentHP = currentHP;
    	this.maximumHP= maximumHP;
    	this.armor = armor;
    	this.attack = attack;
    }
    
    
    
    public int getCurrentHP() {
		return currentHP;
	}

	public void setCurrentHP(int currentHP) {
		this.currentHP = currentHP;
	}

	public int getMaximumHP() {
		return maximumHP;
	}

	public void setMaximumHP(int maximumHP) {
		this.maximumHP = maximumHP;
	}

	public int getArmor() {
		return armor;
	}

	public void setArmor(int armor) {
		this.armor = armor;
	}

	public int getAttack() {
		return attack;
	}

	public void setAttack(int attack) {
		this.attack = attack;
	}

	public List<Spell> getEffect() {
		return effect;
	}

	public void setEffect(List<Spell> effect) {
		this.effect = effect;
	}

	/**
     * @param other
     */
    
    
    
    public void attack(Entity other) {
    	int dammage = this.attack - other.armor;
    	if(dammage < 1) {
    		dammage = 1;
    	}
    	other.currentHP = other.currentHP - dammage;
    }

	/**
     * 
     */
    public boolean isAlive() {
    	if(currentHP>0) {
    		return true;
    	}
    	else return false;

    }

    /**
     * 
     */
    public boolean isDead() {
		return !isAlive();

    }

}