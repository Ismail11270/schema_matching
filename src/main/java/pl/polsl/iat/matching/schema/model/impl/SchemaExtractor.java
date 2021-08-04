package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.exception.DatabaseException;
import pl.polsl.iat.matching.exception.RuntimeDatabaseException;
import pl.polsl.iat.matching.exception.SchemaExtractorException;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.Table;
import pl.polsl.iat.matching.sql.ConnectionFactory;
import pl.polsl.iat.matching.sql.ConnectionProperties;
import pl.polsl.iat.matching.sql.SchemaConnection;
import pl.polsl.iat.matching.util.Const;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.stream.Stream;

public class SchemaExtractor {

    public enum Mode {
        LAZY, EAGER;
    }

    private DatabaseMetaData metaData;
    private String schemaName;
    private ConnectionProperties properties;

    public SchemaExtractor(ConnectionProperties properties) {
        this.properties = properties;
        this.schemaName = properties.getSchemaName();
    }

    public Schema load(Mode extractionMode) throws SchemaExtractorException {
        SchemaImpl.Builder builder = new SchemaImpl.Builder(extractionMode);
        try {
            SchemaConnection connection = ConnectionFactory.getSchemaConnection(this.properties);
            this.metaData = connection.getMetadata();
            builder.setName(schemaName);
            TablesGenerator tablesGenerator = new TablesGenerator(metaData, schemaName, extractionMode);
            builder.setTablesSource(Stream.generate(tablesGenerator).takeWhile(tablesGenerator));
            return builder.build();
        } catch (DatabaseException de) {
            throw new SchemaExtractorException(de, "Error extracting schema.");
        }
    }

}
