package iut.gon.sae.game.save;

import java.util.HashMap;

public class JSONObject {
	
	public HashMap<String, Object> data = new HashMap<String, Object>();
	
	public void put(String key, Object object) {
		data.put(key, object);
		System.out.println(data.values());
	}
	
	public String getString(String key) throws ClassCastException {
		if(data.get(key) != data.getClass()) {
			throw new ClassCastException();
		}
		return (String)data.get(key);
	}
	
	public HashMap<String, Object> getData() {
		return data;
	}

	public void setData(HashMap<String, Object> data) {
		this.data = data;
	}

	/*public Number getNumber(String key) {
		return
	}
	
	public Boolean getBoolean(String key) {
		return 
	}
	
	public JSONObject JSONObject(String key) {
		return
	}
	public JSONArray getJSONArray(String key) {
		
	}*/
	
}
