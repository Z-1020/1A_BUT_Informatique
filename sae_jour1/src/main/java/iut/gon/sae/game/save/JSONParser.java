package iut.gon.sae.game.save;

import java.util.Scanner;

public class JSONParser {
	private String toParse;
	
	public JSONParser(String toParse) {
		this.toParse = toParse.replaceAll("\\s+", "");
	}
	
	public JSONObject parse() {
		return parseObject();
	}
	
	public Object parseValue() {
		if(toParse.startsWith("\"")) {
			return this.parseString();
		}
		else if(toParse.startsWith("{")) {
			return this.parseObject();
		}
		else if(toParse.startsWith("t") || toParse.startsWith("f")) {
			return this.parseBoolean();
		}
		else if(toParse.startsWith("n")) {
			return this.parseNull();
		}
		else if(toParse.startsWith("[")) {
			return this.parseArray();	
		}
		else return null;
		
	}
	
	public String parseString() {
		return toParse;
		
	}
	
	public Boolean parseBoolean() {
		return null;
		
	}
	
	public Number parseNumber() {
		return null;
		
	}
	
	public Object parseNull() {
		return toParse;
		
	}
	
	public JSONArray parseArray() {
		return null;
	}
	
	public JSONObject parseObject() {
		Scanner sc = new Scanner(toParse);
		char c = ' ';
		while(sc.hasNext()) {
			c= sc.next().charAt(0);
			if(c=='}') {
				JSONObject obj = new JSONObject();
				
				sc.close();
				return obj;
			}
			if(c==',') {
				
			}
			else {
				//parseString()
				toParse = sc.next();
				this.parseValue();
			}
		}
		sc.close();
		return null;
	}
}
