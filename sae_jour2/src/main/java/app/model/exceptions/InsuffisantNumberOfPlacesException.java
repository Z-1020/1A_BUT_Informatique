package app.model.exceptions;

public class InsuffisantNumberOfPlacesException extends Exception {
    public InsuffisantNumberOfPlacesException() {
    }

    public InsuffisantNumberOfPlacesException(String message) {
        super(message);
    }
}
