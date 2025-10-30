package iut.gon.sae.game.Entity;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class PlayerTest {

	@Test
	void testPlayer() {
		Player p1 = new Player(100,100,10,10,100,50);
		Player p2 = new Player(100,100,10,10,50,100);
		
		assertTrue(p1.getCurrentMana()<=p1.getMaximumMana());
		assertTrue(p2.getCurrentMana()<=p2.getMaximumMana());
		
	}
	
/*	@Test
	void testCastSpell() {
		Player p1 = new Player(100,100,10,10,100,50);
		Player p2 = new Player(100,100,10,10,50,100);

		

	}*/
}
