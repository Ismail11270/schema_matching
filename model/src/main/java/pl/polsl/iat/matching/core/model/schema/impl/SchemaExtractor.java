package pl.polsl.iat.matching.core.model.schema.impl;

import pl.polsl.iat.matching.core.exception.DatabaseException;
import pl.polsl.iat.matching.core.exception.SchemaExtractorException;
import pl.polsl.iat.matching.core.model.schema.Schema;
import pl.polsl.iat.matching.core.sql.ConnectionFactory;
import pl.polsl.iat.matching.core.sql.ConnectionProperties;
import pl.polsl.iat.matching.core.sql.SchemaConnection;

import java.sql.DatabaseMetaData;
import java.util.stream.Stream;

public class SchemaExtractor {

    public enum Mode {
        LAZY, EAGER;
    }

    public  DatabaseMetaData metaData;
    private String schemaName;
    private ConnectionProperties properties;

    public SchemaExtractor(ConnectionProperties properties) {
        this.properties = properties;
        this.schemaName = properties.getSchemaName();
    }

    public Schema load() throws SchemaExtractorException {
        SchemaImpl.Builder builder = new SchemaImpl.Builder();
        try {
            SchemaConnection connection = ConnectionFactory.getSchemaConnection(this.properties);
            this.metaData = connection.getMetadata();
            builder.setName(schemaName);
            TablesGenerator tablesGenerator = new TablesGenerator(metaData, schemaName);
            builder.setTablesSource(Stream.generate(tablesGenerator).takeWhile(tablesGenerator));
            return builder.build();
        } catch (DatabaseException de) {
            throw new SchemaExtractorException(de, "Error extracting schema.");
        }
    }

}
