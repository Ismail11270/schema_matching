package pl.polsl.iat.matching.core.sql;

import java.util.*;

public class ConnectionProperties {

    public static final String PROPERTIES_DELIMITER = "=";
    private Properties properties;
    private String url = null;

    public enum PropertyName {
        ID,
        DATABASE_TYPE,
        HOST,
        PORT,
        USER,
        PASSWORD,
        SCHEMA;

        public static PropertyName getPropertyName(String name) {
            return valueOf(name.toUpperCase());
        }

        public String getName() {
            return name().toLowerCase(Locale.ROOT);
        }
    }

    public ConnectionProperties(int id, Properties loadedProperties) {
        properties = loadedProperties;
        properties.put(PropertyName.ID.getName(), id);
    }

    public ConnectionProperties() { }

    public String getProperty(Object propName) {
        return properties.getProperty(propName.toString());
    }

    public String getHost() {
        return properties.getProperty(PropertyName.HOST.getName());
    }

    public Integer getPort() {
        return properties.get(PropertyName.PORT) instanceof Integer ? (Integer) properties.get(PropertyName.PORT) : Integer.parseInt(properties.get(PropertyName.PORT).toString());
    }

    public String getUser() {
        return properties.getProperty(PropertyName.USER.getName());
    }

    public String getPassword() {
        return properties.getProperty(PropertyName.PASSWORD.getName());
    }

    public String getSchemaName() {
        return properties.getProperty(PropertyName.SCHEMA.getName());
    }

    public DatabaseType getDatabaseType() {
        return DatabaseType.getType(properties.getProperty(PropertyName.DATABASE_TYPE.getName()));
    }

    public ConnectionProperties confirm(boolean print) {
        if(!print) return this;
        properties.forEach((key, value) -> System.out.println(key + ": " + value));
        return this;
    }

    public void setUrl(String url){
        this.url = url;
    }

    public String getUrl(){
        if(url == null) {
            String host = properties.getProperty(PropertyName.HOST.getName());
            String port = properties.getProperty(PropertyName.PORT.getName());
            return port != null && !port.isBlank() ? host + ":" + port : host;
        }
        return url;
    }

    public Properties getProperties() {
        return properties;
    }
}

