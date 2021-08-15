package pl.polsl.iat.matching.exception;

public class DatabaseException extends Exception {

    public DatabaseException(String msg){
        super(msg);
    }

    public DatabaseException(Throwable t){
        super(t);
    }

    public DatabaseException(String msg, Throwable t){
        super(msg + "\nDetailed messaged: \t " + t.getMessage(),t);
    }

}
