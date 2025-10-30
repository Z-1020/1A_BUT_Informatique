package iut.gon.sae.game;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import iut.gon.sae.game.Entity.Monster;
import iut.gon.sae.game.Entity.Player;
import iut.gon.sae.game.model.Fight.Heal;
import iut.gon.sae.game.model.Fight.ManaGain;
import iut.gon.sae.game.model.Fight.Poison;
import iut.gon.sae.game.model.Fight.Shield;
import iut.gon.sae.game.model.Fight.Spell;
import iut.gon.sae.game.model.Fight.Strength;

class SpellTest {

	@Test
	void testIsSelfSpell1() {
		Poison p = new Poison(5, 6,7,8);
		assertTrue(p.isSelfSpell() == false);
	}
	
	@Test
	void testIsSelfSpell2() {
		Shield s = new Shield(5,6,7,8);
			assertTrue(s.isSelfSpell() == true);
	}
	@Test
	void testApply1() {
		Monster m = new Monster(5,6, 78 ,9, "m");
		Poison s = new Poison(1, 5, 9, 8);
		s.apply(m);
		assertTrue(s.getNbTurnLeft() == 4);
		
	}
	@Test
	void testApply2() {
		Monster m = new Monster(5,6, 78 ,9, "m");
		Poison s = new Poison(1, 0, 9, 8);
		s.apply(m);
		assertTrue(s.getNbTurnLeft() == 0);
		
	}
	@Test
	void testApply3() {
		Monster m = new Monster(5,6, 78 ,9, "m");
		Heal s = new Heal(1, 5,0, 8);
		s.apply(m);
		assertTrue(s.getNbTurnLeft() == 4);
		
	}
	@Test
	void testHeal() {
		Player p = new Player(5,9,54,6,8, 10);
		Heal h =new Heal(10,25,2,4);
		h.applyEffect(p);
		assertTrue(p.getCurrentHP() == 7 );
	}
	
	
	@Test
	void testPoison1() {
		Monster m = new Monster(50,20, 78 ,9, "m");
		Poison s = new Poison(1, 5, 9, 8);
		s.applyEffect(m);
		assertTrue(m.getCurrentHP() == 11);
	}
	@Test
	void testPoison2() {
		Monster m = new Monster(50,30, 78 ,9, "m");
		Poison s = new Poison(1, 5, 8, 8);
		s.applyEffect(m);
		assertTrue(m.getCurrentHP() == 22);
	}
	@Test
	void testPoison3() {
		Monster m = new Monster(50,50, 78 ,9, "m");
		Poison s = new Poison(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getCurrentHP() == 40);
	}
	@Test
	void testSchield1() {
		Player m = new Player(50,50, 78 ,9, 4,6);
		Shield s = new Shield(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getArmor() == 88);
	}
	@Test
	void testSchield2() {
		Player m = new Player(50,50, 78 ,9, 0,6);
		Shield s = new Shield(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getArmor() == 78);
	}
	@Test
	void testSchield3() {
		Player m = new Player(50,50, 78 ,9, -1,6);
		Shield s = new Shield(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getArmor() == 78);
	}
	@Test
	void testStrength1() {
		Player m = new Player(50,50, 78 ,9, 4,6);
		Strength s = new Strength(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getAttack() == 19);
	}
	@Test
	void testStrength2() {
		Player m = new Player(50,50, 78 ,11, 0,6);
		Strength s = new Strength(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getAttack() == 11);
	}
	@Test
	void testStrength3() {
		Player m = new Player(50,50, 78 ,11, 0,6);
		Strength s = new Strength(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getAttack() == 11);
	}
	
	@Test
	void testManaGain1() {
		Player m = new Player(50,50, 78 ,9, 4,6);
		ManaGain s = new ManaGain(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getCurrentMana() == 14);
	}
	@Test
	void testManaGain2() {
		Player m = new Player(50,50, 78 ,9, 0,6);
		ManaGain s = new ManaGain(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getCurrentMana() == 0);
	}
	@Test
	void testManaGain3() {
		Player m = new Player(50,50, 78 ,9,-1,6);
		ManaGain s = new ManaGain(1, 5, 10, 8);
		s.applyEffect(m);
		assertTrue(m.getCurrentMana() == -1);
	}
	
	

}
