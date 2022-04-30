package pl.polsl.iat.matching.core.sql;

public class SqlUtil {

    public static String buildConnectionAddress(ConnectionProperties properties){
        return new StringBuilder("jdbc:")
                .append(properties.getDatabaseType().prefix).append("://")
                .append(properties.getHost()).append(":")
                .append(properties.getPort()).append("/")
                .append(properties.getSchemaName()).toString();
    }

}
