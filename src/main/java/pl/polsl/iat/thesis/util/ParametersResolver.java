package pl.polsl.iat.thesis.util;

import pl.polsl.iat.thesis.sql.ConnectionProperties;

import java.security.InvalidParameterException;
import java.util.Arrays;
import java.util.Stack;
import java.util.Vector;

public class ParametersResolver {

    private final String SCHEMA_ONE = "-s1";
    private final String SCHEMA_TWO = "-s2";
    private final String PROPERTIES = "-p";

    public ConnectionProperties resolveParams(String args[]){
        //-s1 -p c:\projects\thesis\schema_matching\resources\schema1.properties
        //-s2 -p c:\projects\thesis\schema_matching\resources\schema2.properties
        ConnectionProperties.Builder b1 = new ConnectionProperties.Builder(), b2 = new ConnectionProperties.Builder();
        if(args.length == 0){
            throw new InvalidParameterException("Missing parameters");
        }
        Stack<String> argsStack = new Stack<>();
        argsStack.addAll(Arrays.asList(args));
        while(!argsStack.empty()){
            String argSwitch = argsStack.pop();
            if(argSwitch.startsWith("-")){
                switch(argSwitch){
                    case(SCHEMA_ONE):
                    {
                        String val = argsStack.pop();
                        //process props
                    }
                    case(SCHEMA_TWO):
                    {

                    }
                }
            }
        }

    }
}
