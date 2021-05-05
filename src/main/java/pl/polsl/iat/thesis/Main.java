package pl.polsl.iat.thesis;

import pl.polsl.iat.thesis.sql.JdbcConnection;
import pl.polsl.iat.thesis.util.ParametersResolver;

import java.util.Arrays;

public class Main {

    public static void main(String[] args) {
        System.out.println(Arrays.toString(args));
        ParametersResolver parametersResolver = new ParametersResolver(args);

    }
}
