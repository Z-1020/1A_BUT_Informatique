package app.ai;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Set;

import app.model.map.Place;
import app.model.map.World;

public class WorldAnalyzer{
	
	private World world;
	
	WorldAnalyzer(World w){
		this.world = w;
	}
	
	/*vérifie si le graphe des places est connexe*/
	public boolean isConnexe() {
		
		ArrayList<Place> parcourus = new ArrayList<Place>();
		ArrayList<Place> file = new ArrayList<Place>();
		file.add(this.world.getPlaces().get(0));
		parcourus.add(this.world.getPlaces().get(0));
		while(!file.isEmpty()) {
			Place p = file.remove(0);
			
			for(Place p2 : world.getPathsFrom(p).keySet()) {
				if(!parcourus.contains(p2)) {
					file.add(p2);
					parcourus.add(p2);
				}
				
			}
		}
		return parcourus.size() == world.getPlaces().size();
		
		
	}

	List<Map<Place,Integer>> dijkstraWithStep(Place start){
		List<Map<Place, Integer>> list = new ArrayList<Map<Place, Integer>>(); //list des chemins 
		Map<Place, Integer> distance = start.getPaths();
		Set<Place> visited = new HashSet<Place>();
		PriorityQueue<Place> listnode = new PriorityQueue<Place>(Comparator.comparingInt(comp -> distance.getOrDefault(comp, Integer.MAX_VALUE)));
		listnode.add(start);
		distance.put(start, 0);
		Integer min=Integer.MAX_VALUE;
		/*Tant que la liste est rempli*/
		while(! listnode.isEmpty()) {
			Place current = listnode.poll(); // on prend le premier élément de liste et on le supprime
			if(min > distance.get(current)) { // si la valeur est inférieur à min, min prendra sa valeur
				min = distance.get(current);
			}
			/* si le noeud contient le chemin minimum, on l'ajoute à la liste*/
			if(current.getPaths().containsKey(min)) {
				visited.add(current); //on l'ajoute à la liste
				distance.put(current, min);
			}
			list.add(distance);
		}
		return list;
	}	
		

	public boolean isFinishable() {
		for(Place start : this.world.getPlaces()) {
			if(start.isStart()) {
				int fins = 0;
				ArrayList<Place> parcourus = new ArrayList<Place>();
				ArrayList<Place> file = new ArrayList<Place>();
				file.add(start);
				parcourus.add(start);
				while(!file.isEmpty()) {
					Place p = file.remove(0);
					
					for(Place p2 : world.getPathsFrom(p).keySet()) {
						if(!parcourus.contains(p2) && !p2.hasMonster()) {
							file.add(p2);
							parcourus.add(p2);
							if(p2.isEnd()) {
								fins++;
							}
						}
						
					}
				}
				if(fins < 1) {
					return false;
				}
			}
		}
		return true;

	}
	
}