package app.ai;

import java.util.List;
import java.util.Map;

public interface INode<T> {
	
	public boolean isGoal();
	
	public boolean isDeadLock();
	
	public Map<INode<T>, Integer> getNeighbors();
	
	public List<INode<T>> rebuildPath();
	
	public T getPath();
	
	public INode<T> getParent();
	
	public int getCost();
	
}