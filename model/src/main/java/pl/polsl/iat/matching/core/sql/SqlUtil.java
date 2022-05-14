package pl.polsl.iat.matching.core.sql;

public class SqlUtil {

    public static String buildConnectionAddress(ConnectionProperties properties){
        if(properties.getDatabaseType() == DatabaseType.SQLSERVER) {
            System.out.println("YES");
            return "jdbc:sqlserver://localhost;instanceName=MSSQLSERVER04;integratedSecurity=true;";
//            return String.format("jdbc:sqlserver://%s;user=%s;password=%s;", properties.getHost(), properties.getUsername(), properties.getPassword());
        }
        return new StringBuilder("jdbc:")
                .append(properties.getDatabaseType().prefix).append("://")
                .append(properties.getHost()).append(":")
                .append(properties.getPort()).append("/")
                .append(properties.getSchemaName()).toString();
    }

}
