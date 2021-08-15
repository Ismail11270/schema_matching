package pl.polsl.iat.matching.sql;

import pl.polsl.iat.matching.exception.DatabaseException;

import java.util.Hashtable;
import java.util.Map;

public class ConnectionFactory {
    private ConnectionFactory(){
    }

    private static final Map<String,SchemaConnection> availableConnections = new Hashtable<>();

    public static SchemaConnection getSchemaConnection(String schemaName) {
        return availableConnections.get(schemaName);
    }

    public static SchemaConnection getSchemaConnection(ConnectionProperties properties) throws DatabaseException {
        var name = properties.getSchemaName();
        if(availableConnections.containsKey(name)) {
            return availableConnections.get(name);
        }
        SchemaConnection connection = new SchemaConnection(properties);
        availableConnections.put(name, connection);
        return connection;
    }
}
