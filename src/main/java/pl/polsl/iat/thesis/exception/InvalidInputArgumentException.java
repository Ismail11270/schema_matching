package pl.polsl.iat.thesis.exception;

import java.security.InvalidParameterException;

public class InvalidInputArgumentException extends InvalidParameterException {

    public InvalidInputArgumentException(String msg){
        super(msg);
    }

    public InvalidInputArgumentException(Exception e){
        this(e.getMessage());
    }

    public InvalidInputArgumentException(String msg, String argSwitch){
        this(msg);
        relatedArgumentSwitch = argSwitch;
    }

    private String relatedArgumentSwitch;

    public void setSwitch(String argSwitch){
        relatedArgumentSwitch = argSwitch;
    }

    @Override
    public String getMessage() {
        String msg = super.getMessage();
        if(relatedArgumentSwitch!=null){
            msg = "Error in argument: " + relatedArgumentSwitch + ". \nDetailed message: " + msg;
        }
        return msg;
    }
}
