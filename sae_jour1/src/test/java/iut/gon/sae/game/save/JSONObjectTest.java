package iut.gon.sae.game.save;

import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class JSONObjectTest {

	@Test
	void testPut1() {
		JSONObject j = new JSONObject();
		j.put("file", 21);
		assertTrue(j.data.containsValue("file") == true);
		
	}
	@Test
	void testPut2() {
		JSONObject j = new JSONObject();
		j.put( "", 21);
		assertTrue(j.data.containsValue("") == true);
		
	}
	@Test
	void testPut3() {
		JSONObject j = new JSONObject();
		j.put( "", 21);
		assertTrue(j.data.containsKey(21) == true);
		
	}

}
