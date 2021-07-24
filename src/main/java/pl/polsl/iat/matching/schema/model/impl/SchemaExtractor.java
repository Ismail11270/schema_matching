package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.exception.DatabaseException;
import pl.polsl.iat.matching.exception.SchemaExtractorException;
import pl.polsl.iat.matching.schema.MetadataLoader;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.sql.ConnectionProperties;
import pl.polsl.iat.matching.sql.SchemaConnection;

public class SchemaExtractor {

    public enum Mode {
        LAZY, EAGER, STANDARD;
    }

    private Mode mode = Mode.STANDARD;

    public SchemaExtractor(Mode mode) {
        this.mode = mode;
    }

    public Schema load(ConnectionProperties properties) throws SchemaExtractorException {
        //TODO redefine schema creation after schema class is fixed
        SchemaImpl.Builder builder = new SchemaImpl.Builder();
        try {
            SchemaConnection connection = new SchemaConnection(properties);
            MetadataLoader metadataLoader = new MetadataLoader(connection.getMetadata());
            builder.setTablesSource(metadataLoader.getTables(mode));
            return builder.build();
        } catch (DatabaseException de){
            throw new SchemaExtractorException(de, "Error extracting schema.");
        }
    }



}
