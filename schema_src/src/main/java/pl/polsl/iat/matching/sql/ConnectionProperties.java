package pl.polsl.iat.matching.sql;

import java.security.InvalidParameterException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Stream;

public class ConnectionProperties {

    public static final String PROPERTIES_DELIMITER = "=";

    private String url = null;

    public enum PropertyName {
        ID,
        DATABASE_TYPE,
        HOST,
        PORT,
        USERNAME,
        PASSWORD,
        SCHEMA;

        public static PropertyName getPropertyName(String name) {
            return valueOf(name.toUpperCase());
        }
    }

    public ConnectionProperties() {
    }

    public void setId(int id) {
        propertiesMap.put(PropertyName.ID, id);
    }

    private Map<PropertyName, Object> propertiesMap = Stream.of(PropertyName.values()).collect(HashMap::new, (m, p) -> m.put(p, null), HashMap::putAll);

    public Object getProperty(PropertyName propertyName){
        return propertiesMap.get(propertyName);
    }

    public String getHost() {
        return (String) propertiesMap.get(PropertyName.HOST);
    }

    public Integer getPort() {
        return propertiesMap.get(PropertyName.PORT) instanceof Integer ? (Integer) propertiesMap.get(PropertyName.PORT) : Integer.parseInt(propertiesMap.get(PropertyName.PORT).toString());
    }

    public String getUsername() {
        return (String) propertiesMap.get(PropertyName.USERNAME);
    }

    public String getPassword() {
        return (String) propertiesMap.get(PropertyName.PASSWORD);
    }

    public String getSchemaName() {
        return (String) propertiesMap.get(PropertyName.SCHEMA);
    }

    public DatabaseType getDatabaseType() {
        return (DatabaseType) propertiesMap.get(PropertyName.DATABASE_TYPE);
    }

    public void putProperty(String propName, String propValue) {
        PropertyName pa = PropertyName.valueOf(propName.toUpperCase(Locale.ROOT));
        if (!propertiesMap.containsKey(pa)) {
            throw new InvalidParameterException("Invalid property in properties file - " + propName + ".");
        }
        if (pa == PropertyName.PORT) {
            try {
                propertiesMap.put(pa, Integer.parseInt(propValue));
            } catch (NumberFormatException e) {
                throw new InvalidParameterException("Wrong value for PORT property in properties file.");
            }
        } else if (pa == PropertyName.DATABASE_TYPE) {
            try {
                propertiesMap.put(pa, DatabaseType.getType(propValue));
            } catch (IllegalArgumentException iae) {
                throw new InvalidParameterException("Database type specified in properties file is not supported - " + propValue + ".");
            }
        } else {
            propertiesMap.put(pa, propValue);
        }
    }

    public ConnectionProperties confirm(boolean print) {
        if (propertiesMap.containsValue(null))
            throw new InvalidParameterException("Error parsing connection properties. Please make sure the provided properties are correct.");
        if(!print) return this;
        System.out.println("Properties verified:");
        propertiesMap.forEach((key, value) -> System.out.println(key + ": " + value));
        return this;
    }

    public void setUrl(String url){
        this.url = url;
    }

    public Optional<String> getUrl(){
        return Optional.of(url);
    }
}

