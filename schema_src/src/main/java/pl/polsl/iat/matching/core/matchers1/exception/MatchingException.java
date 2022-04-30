package pl.polsl.iat.matching.core.matchers1.exception;

public class MatchingException extends RuntimeException {
    public MatchingException(String msg){
        super(msg);
    }

    public MatchingException(Throwable t){
        super(t);
    }

    public MatchingException(String msg, Throwable t){
        super(msg + "\nDetailed messaged: \t " + t.getMessage(),t);
    }
}
