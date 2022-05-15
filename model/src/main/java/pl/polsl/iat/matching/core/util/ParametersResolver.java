package pl.polsl.iat.matching.core.util;

import pl.polsl.iat.matching.core.exception.InvalidInputArgumentException;
import pl.polsl.iat.matching.core.sql.ConnectionProperties;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.stream.Stream;

public class ParametersResolver {

    private final String SWITCH_SCHEMA= "-s";
    private final String SWITCH_PROPERTIES_FILE = "-f";

    private List<ConnectionProperties> connectionProperties = new ArrayList<>();

    public ParametersResolver() {

    }

    public ParametersResolver(String[] args) {
        resolveParams(args);
    }

    public void resolveParams(String[] args) throws InvalidParameterException {
        //-s1 -f C:\work\schema_matching\resources\schema1.properties
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
//                    throw new InvalidInputArgumentException(e.getMessage(), argSwitch);
                }
            } else {
                throw new InvalidInputArgumentException("Wrong input parameters.");
            }
        }
    }

    private void prepareSchemaConnectionFromPropertiesFile(int id, String path) {
        try {
            connectionProperties.add(createConnectionFromProperties(id, path));
        } catch (IOException e) {
            throw new InvalidParameterException("Failed to access the provided properties file - " + path + " does not exist or cannot be opened.");
        }
    }


    private ConnectionProperties createConnectionFromProperties(int id, String path) throws IOException {
        Properties properties = new Properties();
        properties.load(new FileInputStream(path));
        ConnectionProperties conProps = new ConnectionProperties(id, properties);
        return conProps.confirm(true);
    }

    public List<ConnectionProperties> getConnectionProperties(){
        return connectionProperties;
    }
}
