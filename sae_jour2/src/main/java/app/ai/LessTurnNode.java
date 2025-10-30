package app.ai;

import app.model.entity.Monster;
import app.model.entity.Player;

public class LessTurnNode<Spell> extends FightNode<Spell> {

	public LessTurnNode(int c, Node<Spell> par, Spell pat, Player player, Monster monster) {
		super(c, par, pat, player, monster);
	}

	
	public int getHeuristic() {
		return (int) Math.ceil(monster.getCurrentHP()/player.getAttack());
	}
}
