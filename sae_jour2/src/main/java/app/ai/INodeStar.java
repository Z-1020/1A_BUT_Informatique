package app.ai;

public interface INodeStar<T> extends INode<T>{
	public int getHeuristic();
}