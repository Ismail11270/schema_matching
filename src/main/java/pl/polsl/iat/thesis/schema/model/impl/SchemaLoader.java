package pl.polsl.iat.thesis.schema.model.impl;

import pl.polsl.iat.thesis.schema.model.Schema;
import pl.polsl.iat.thesis.sql.ConnectionProperties;

public class SchemaLoader {

    public static Schema load(ConnectionProperties properties){
        //TODO redefine schema creation after schema class is fixed
        Schema schema = new SchemaImpl.Builder().build();
        return schema;
    }


}
