package pl.polsl.iat.thesis.util;

import pl.polsl.iat.thesis.exception.InvalidInputArgumentException;
import pl.polsl.iat.thesis.sql.ConnectionProperties;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ParametersResolver {

    private final String SWITCH_SCHEMA= "-s";
    private final String SWITCH_PROPERTIES_FILE = "-f";

    private List<ConnectionProperties> connectionProperties = new ArrayList<>();

    public ParametersResolver() {

    }

    public ParametersResolver(String args[]) {
        resolveParams(args);
    }

    public void resolveParams(String args[]) throws InvalidParameterException {
        //-s1 -f c:\projects\thesis\schema_matching\resources\schema1.properties
        //-s2 -f c:\projects\thesis\schema_matching\resources\schema2.properties
        if (args.length == 0) {
            throw new InvalidParameterException("Missing parameters");
        }
        ArrayList<String> argsList = new ArrayList<>(Arrays.asList(args));
        int counter = 0;
        while (!argsList.isEmpty()) {
            String argSwitch = argsList.remove(0);
            if (argSwitch.startsWith(SWITCH_SCHEMA)) {
                try {
                    if (Integer.parseInt(argSwitch.substring(2)) != ++counter)
                        throw new InvalidInputArgumentException("Invalid connection id.");
                    String inputType = argsList.remove(0);
                    if (SWITCH_PROPERTIES_FILE.equals(inputType))
                        prepareSchemaConnectionFromPropertiesFile(counter, argsList.remove(0));
                    else
                        throw new InvalidInputArgumentException("Unsupported input parameter.", inputType);
                    //TODO implement some other type of connection settings ......
                } catch (Exception e) {
                    throw new InvalidInputArgumentException(e.getMessage(), argSwitch);
                }
            } else {
                throw new InvalidInputArgumentException("Wrong input parameters.");
            }
        }
    }

    private void prepareSchemaConnectionFromPropertiesFile(int id, String path) {
        try {
            connectionProperties.add(createConnectionFromProperties(id, Files.readAllLines(Paths.get(new File(path).toURI()))));
        } catch (IOException e) {
            throw new InvalidParameterException("Failed to access the provided properties file - " + path + " does not exist or cannot be opened.");
        }
    }

    private ConnectionProperties createConnectionFromProperties(int id, List<String> lines) {
        ConnectionProperties properties = new ConnectionProperties();
        properties.setId(id);
        for (int i = 0; i < lines.size(); i++) {
            String[] property = lines.get(i).split(ConnectionProperties.PROPERTIES_SEPARATOR);
            if (property.length > 2)
                throw new InvalidParameterException("Invalid property at line " + i);
            properties.putProperty(property[0].trim(), property[1].trim());
        }
        return properties.confirm(true);
    }
}
