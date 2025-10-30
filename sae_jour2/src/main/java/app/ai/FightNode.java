package app.ai;

import java.util.HashMap;
import java.util.Map;

import app.model.entity.Monster;
import app.model.entity.Player;
import app.model.fight.Spell;

public class FightNode<Spell> extends Node<Spell> implements INodeStar<Spell> {
	
	protected Player player;
	protected Monster monster;

	public FightNode(int c, Node<Spell> par, Spell pat, Player player, Monster monster) {
		super(c, par, pat);
		this.player = player.clone();
		this.monster = monster.clone();
	}

	public int getHeuristic() {
		return 0;
	}

	@Override
	public boolean isGoal() {
		return monster.isDead();
	}

	@Override
	public boolean isDeadLock() {
		return player.isDead();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<INode<Spell>, Integer> getNeighbors() {
		Map<INode<Spell>, Integer> map = new HashMap<INode<Spell>, Integer>();
		
		for(app.model.fight.Spell s : player.availableSpells()) {
			Player newPlayer = player.clone();
			Monster newMonster = monster.clone();
			if(s.isSelfSpell()) {
				s.applyEffect(newPlayer);
			}
			else {
				s.applyEffect(newMonster);
			}
			map.put(new FightNode<Spell>(this.getCost(), this, (Spell) s, newPlayer, newMonster), newPlayer.availableSpells().size()+1);
		}
		Player newPlayer = player.clone();
		Monster newMonster = monster.clone();
		newPlayer.attack(newMonster);
		map.put(new FightNode<Spell>(this.getCost(), this, null, newPlayer, newMonster), newPlayer.availableSpells().size()+1);
		
		
		return map;
	}
	
}