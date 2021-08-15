package pl.polsl.iat.matching.exception;

public class RuntimeDatabaseException extends RuntimeException {

    public RuntimeDatabaseException(String msg){
        super(msg);
    }

    public RuntimeDatabaseException(Throwable t){
        super(t);
    }

    public RuntimeDatabaseException(String msg, Throwable t){
        super(msg + "\nDetailed messaged: \t " + t.getMessage(),t);
    }


}
