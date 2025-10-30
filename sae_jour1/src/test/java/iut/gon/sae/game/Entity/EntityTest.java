package iut.gon.sae.game.Entity;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class EntityTest {

	@Test
	void testEntity() {
		Entity e1 = new Monster(100,50,10,10,"Gnome");
		Entity e2 = new Monster(50,100,10,10,"Lutin");
		
		assertTrue(e1.currentHP<=e1.maximumHP);
		assertTrue(e2.currentHP<=e2.maximumHP);
		
	}
	
	@Test
	void testAttack() {
		Entity e1 = new Monster(100,100,3,7,"Gnome");
		Entity e2 = new Monster(100,100,4,10,"Lutin");
		Entity e3 = new Monster(100,100,50,6,"Tank");
		
		e1.attack(e2);
		e1.attack(e3);
		
		assertEquals(97,e2.currentHP);
		assertEquals(99,e3.currentHP);
	}
	
	@Test
	void testIsAlive() {
		Entity e1 = new Monster(0,100,3,7,"Gnome");
		Entity e2 = new Monster(100,100,4,10,"Lutin");
		Entity e3 = new Monster(-100,100,4,10,"Lutin");
		
		assertFalse(e1.isAlive());
		assertTrue(e2.isAlive());
		assertFalse(e3.isAlive());
		
	}
	
	@Test
	void testIsDead() {
		Entity e1 = new Monster(0,100,3,7,"Gnome");
		Entity e2 = new Monster(100,100,4,10,"Lutin");
		Entity e3 = new Monster(-100,100,4,10,"Lutin");
		
		assertTrue(e1.isDead());
		assertFalse(e2.isDead());
		assertTrue(e3.isDead());
		
	}
}
