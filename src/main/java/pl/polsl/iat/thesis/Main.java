package pl.polsl.iat.thesis;

import pl.polsl.iat.thesis.sql.JdbcConnection;
import pl.polsl.iat.thesis.util.ParametersResolver;

public class Main {

    public static void main(String[] args) {
        new ParametersResolver().resolveParams(args);
    }
}
