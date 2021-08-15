package pl.polsl.iat.matching.sql.query;

public class GenericQuery {

    public static final String SELECT_FROM = "SELECT %s FROM %s";
    public static final String SELECT_ALL_FROM = String.format(SELECT_FROM, "*", "%s");
    public static final String SELECT_FROM_WHERE = "SELECT %s FROM %s WHERE %s;";
    public static final String SELECT_ALL_FROM_WHERE = String.format(SELECT_FROM_WHERE, "*", "%s", "%s");


}
