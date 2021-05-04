package pl.polsl.iat.thesis.sql;

public class ConnectionProperties {

    private String host;
    private int port;

    private String username;
    private String password;

    private String schemaName;
    private DatabaseType databaseType;

    private ConnectionProperties(){

    }

    public String getHost() {
        return host;
    }

    public int getPort() {
        return port;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getSchemaName() {
        return schemaName;
    }

    public DatabaseType getDatabaseType() {
        return databaseType;
    }


    public static class Builder {
        ConnectionProperties properties;

        public Builder() {
            properties = new ConnectionProperties();
        }

        public void setHost(String host) {
            properties.host = host;
        }

        public void setPort(int port) {
            properties.port = port;
        }

        public void setUsername(String username) {
            properties.username = username;
        }

        public void setPassword(String password) {
            properties.password = password;
        }

        public void setDatabaseType(DatabaseType type) {
            properties.databaseType = type;
        }

        public void setSchemaName(String schema) {
            properties.schemaName = schema;
        }

        public ConnectionProperties build(){
            return properties;
        }
    }

}
