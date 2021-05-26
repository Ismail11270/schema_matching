package pl.polsl.iat.thesis;

import pl.polsl.iat.thesis.exception.DatabaseException;
import pl.polsl.iat.thesis.schema.model.Schema;
import pl.polsl.iat.thesis.schema.model.Table;
import pl.polsl.iat.thesis.sql.JdbcConnection;
import pl.polsl.iat.thesis.util.ParametersResolver;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.function.UnaryOperator;
import java.util.stream.Stream;

public class Main {

    public static void main(String[] args) throws DatabaseException, SQLException {
        System.out.println(Arrays.toString(args));
        ParametersResolver parametersResolver = new ParametersResolver(args);
        JdbcConnection connection1 = new JdbcConnection(parametersResolver.getConnectionProperties().get(0));
        connection1.whatTables();
        connection1.test_metadata();


//        Stream.iterate(1)
//        Schema schema = new Schema();

    }
}
