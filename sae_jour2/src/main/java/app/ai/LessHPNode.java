package app.ai;

import app.model.entity.Monster;
import app.model.entity.Player;

public class LessHPNode<Spell> extends FightNode<Spell> {

	public LessHPNode(int c, Node<Spell> par, Spell pat, Player player, Monster monster) {
		super(c, par, pat, player, monster);
	}

	
	public int getHeuristic() {
		return super.player.getMaximumHP()-super.player.getCurrentHP();
	}
}
