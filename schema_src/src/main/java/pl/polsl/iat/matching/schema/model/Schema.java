package pl.polsl.iat.matching.schema.model;


import pl.polsl.iat.matching.sql.ConnectionProperties;

public interface Schema extends ComponentsProvider<Table> {

    String getName();
//    ConnectionProperties getSchemaConnectionProperties();

}
