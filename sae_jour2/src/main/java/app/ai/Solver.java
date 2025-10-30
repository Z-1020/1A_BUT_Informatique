package app.ai;

import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Set;
import java.util.Stack;

public abstract class Solver<T> {
	
	public INode<T> DFS(INode<T>startingNode){
		Stack<INode<T>> list = new Stack<>();
		Set<INode<T>> visited = new HashSet<>();
		list.push(startingNode);
		while(!list.isEmpty()) {
			INode<T> current = list.pop();
			if(list.contains(current)) {
				continue;
			}
			visited.add(current);
			if(current.isGoal()) {
				return current;
			}
			else if(current.isDeadLock()) {
				return null;
			}
			for(INode<T> neighbor: current.getNeighbors().keySet()) {
				list.push(neighbor);
			}
			
		}
		
		return null;
	}
	
	public INodeStar<T> AStar(INodeStar<T>startingNode){
		Map<INodeStar<T>, Integer> costMap = new HashMap<>();
		
		PriorityQueue<INodeStar<T>> strangers = new PriorityQueue<>(Comparator.comparingInt(node -> node.getHeuristic()));
		Set<INodeStar<T>> visited = new HashSet<>();
		
		strangers.add(startingNode);
		costMap.put(startingNode, startingNode.getCost());
		
		while(!strangers.isEmpty()){
			INodeStar<T> current = strangers.poll();
			if(current.isGoal()) {
				return current;
			}
			
			visited.add(current);
			for(Map.Entry<INode<T>, Integer> entry : current.getNeighbors().entrySet()) {
				INodeStar<T> neighbor = (INodeStar<T>) entry.getKey();
				int cost = costMap.get(current)+entry.getValue();
				if(visited.contains(neighbor)) {
					continue;
				}
				boolean notStrangers = !strangers.contains(neighbor);
				boolean path = !costMap.containsKey(neighbor) || cost < costMap.get(neighbor);
				if(notStrangers || path) {
					costMap.put(neighbor, cost);
					strangers.add(neighbor);
				}
			}
		}
		
		return null;
	}
	
}
