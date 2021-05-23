package pl.polsl.iat.thesis.sql.query;

import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class GeneralQuery {
    public static String listTablesForSchema(String SCHEMA, String[] columns) {
        return makeQuery(GenericQuery.SELECT_FROM_WHERE,
                columns,
                "information_schema.tables",
                "table_schema='university'");
    }

    private static String makeQuery(String query, String[] columns, String... args) {
        String[] input = Stream.concat(
                Stream.of(String.join(", ", columns)),
                Arrays.stream(args)).toArray(String[]::new);
        return String.format(query, (Object[]) input);
    }
}
