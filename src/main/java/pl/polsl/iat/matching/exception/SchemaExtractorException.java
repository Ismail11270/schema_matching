package pl.polsl.iat.matching.exception;

public class SchemaExtractorException extends RuntimeException{
    private String msg;

    public SchemaExtractorException(Throwable t){
        super(t);
    }

    public SchemaExtractorException(String msg){
        super(msg);
    }

    public SchemaExtractorException(Throwable t, String msg){
        super(t);
        this.msg = msg;
    }

    @Override
    public String getMessage(){
        return msg == null ? super.getMessage() : msg + " details - \n" + super.getMessage();
    }

}
