package pl.polsl.iat.matching.dictionary.exception;

public class DictionaryException extends Exception {
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
