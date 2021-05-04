package pl.polsl.iat.thesis.sql;

public class SqlUtil {

    public static String buildConnectionAddress(ConnectionProperties properties){
        return new StringBuilder("jdbc:")
                .append(properties.getDatabaseType().prefix).append("://")
                .append(properties.getHost()).append(":")
                .append(properties.getPort()).append("/")
                .append(properties.getSchemaName()).toString();
    }

}
