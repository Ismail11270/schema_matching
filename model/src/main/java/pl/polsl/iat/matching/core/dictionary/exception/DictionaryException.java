package pl.polsl.iat.matching.core.dictionary.exception;

public class DictionaryException extends RuntimeException {
    public DictionaryException(Throwable t){
        super(t);
    }
    public DictionaryException(Throwable t, String msg){
        super(msg, t);
    }

    public DictionaryException(String msg){
        super(msg);
    }
}
