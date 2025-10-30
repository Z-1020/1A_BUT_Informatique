package app.ai;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import app.model.parser.JSONArray;
import app.model.parser.JSONObject;
import app.model.parser.JSONParser;

public class API {
	private static String key = "";
	private URL url;
	private JSONObject json;
	public static String nom;
	public static String desc;

	public API() {
		try {
			url = new URL(
					"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key="
							+ API.key);

			try {
				JSONObject messagePart = new JSONObject();
				messagePart.put("text",
						"Envoies moi un nom pour un Lieu dans un jeu et sa description. Peux-tu me les envoyer sous la forme <Nom> | <Description>");

				JSONArray partsArray = new JSONArray();
				partsArray.add(messagePart);

				JSONObject content = new JSONObject();
				content.put("parts", partsArray);

				JSONArray contentsArray = new JSONArray();
				contentsArray.add(content);

				JSONObject requestBody = new JSONObject();
				requestBody.put("contents", contentsArray);

				HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				connection.setRequestMethod("POST");
				connection.setRequestProperty("Content-Type", "application/json; utf-8");
				connection.setDoOutput(true);

				try (OutputStream os = connection.getOutputStream()) {
					byte[] input = requestBody.toString().getBytes("utf-8");
					os.write(input, 0, input.length);
				}
				int resCode = connection.getResponseCode();
				// System.out.println(resCode);
				InputStream inputStream = connection.getInputStream();

				try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream, "utf-8"))) {
					StringBuilder res = new StringBuilder();
					String ligne;
					while ((ligne = br.readLine()) != null) {
						res.append(ligne);
					}

					JSONParser parser = new JSONParser(res.toString());
					JSONObject obj = parser.parse();
					String texte = ((JSONObject) ((JSONArray) ((JSONObject) ((JSONObject) ((JSONArray) obj.get("candidates")).get(0)).get("content")).get("parts")).get(0)).getString("text");

					Pattern pattern = Pattern.compile("^(.*?)\\s*\\|\\s*(.*)", Pattern.DOTALL);
			        Matcher matcher = pattern.matcher(texte);
			        matcher.find();
			        this.nom = matcher.group(1);
			        this.desc = matcher.group(2);

				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		}

	}

	public static void main(String args[]) {
		API a = new API();

	}
}
