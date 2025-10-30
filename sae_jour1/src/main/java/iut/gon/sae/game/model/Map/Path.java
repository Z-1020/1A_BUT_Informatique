package iut.gon.sae.game.model.Map;
/**
 * 
 */
public class Path {
	
	public Place firstPlace;
    public Place secondPlace;
    public int lenght;
    

    
    public Path(Place firstPlace, Place secondPlace, int lenght) {
    	this.firstPlace = firstPlace;
    	this.secondPlace = secondPlace;
    	this.lenght = lenght;
    }


    /* public Place liaison throw UnknowPlaceException{

    }*/
}