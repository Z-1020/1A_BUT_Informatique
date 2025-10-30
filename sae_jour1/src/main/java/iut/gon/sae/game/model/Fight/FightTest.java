package iut.gon.sae.game.model.Fight;

import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import iut.gon.sae.game.Entity.Monster;
import iut.gon.sae.game.Entity.Player;

class FightTest {

	@Test
	public void testTurn() {
		Fight f1 = new Fight();
		Poison s = new Poison(10,2,5,4);
		assertTrue(f1.turn(s).getClass().equals(Monster.class) );
	}

	@Test
	public void testIsDied() {
		Player p1 = new Player();
		assertTrue(p1.getCurrentHP() == 0);
	}
}
