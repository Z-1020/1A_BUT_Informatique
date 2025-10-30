package app.ai;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public abstract class Node<T> implements INode<T> {

	protected int cost;
	protected INode<T> parent;
	protected T path;

	
	public Node(int c, T pat) {
		this.cost = c;
		this.parent = null;
		this.path = pat;
	}
	
	
	public Node(int c, Node<T> par, T pat){
		
		this.cost = c;
		this.parent = par;
		this.path = pat;
		
	}
	
	@Override
	public abstract boolean isGoal();

	@Override
	public abstract boolean isDeadLock();

	@Override
	public abstract Map<INode<T>, Integer> getNeighbors();

	@Override
	public List<INode<T>> rebuildPath() {
		
		List<INode<T>> l = new ArrayList<INode<T>>();
		l.add(this);
		Node<T> actualPath = (Node<T>) this.parent;
		while(actualPath != null) {
			l.add(actualPath);
			actualPath = (Node<T>) actualPath.getParent();
		}
		
		return l;
	}

	@Override
	public T getPath() {
		return this.path;
	}

	@Override
	public INode<T> getParent() {
		return this.parent;
	}

	@Override
	public int getCost() {
		return this.cost;
	}

}