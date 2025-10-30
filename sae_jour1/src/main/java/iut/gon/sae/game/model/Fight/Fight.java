package iut.gon.sae.game.model.Fight;

import java.util.*;

import iut.gon.sae.game.Entity.*;

/**
 * 
 */
public class Fight {
	private final Player player;
	private final Monster monster;

	public Fight() {
		this.player = new Player();
		this.monster = new Monster();
	}

	public Entity turn(Spell spell) {
		Entity nouvTour = newTurn();
		if(spell != null) {
			player.attack(monster);
		}else {
			player.castSpell(spell, monster);
		}
		if(player.isDead() == true){
			return monster;
		}else if (monster.isDead() == true) {
			return player;
		}else {
			return null;
		}
	}

	public Entity newTurn() {
		for(int p = player.getEffect().size(); p >= 0; p--) {
			player.getEffect().get(p).apply(player);
			player.getEffect().get(p).setNbTurnLeft(player.getEffect().get(p).getNbTurnLeft()-1);
		}
		return player;
	}

}