package app.ai;

import app.model.entity.Monster;
import app.model.entity.Player;

public class LessManaNode<Spell> extends FightNode<Spell> {

	public LessManaNode(int c, Node<Spell> par, Spell pat, Player player, Monster monster) {
		super(c, par, pat, player, monster);
	}
	
	@Override
	public int getHeuristic() {
		return player.getMaximumMana() - player.getCurrentMana();
	}
	
	
	
}