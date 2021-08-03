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
import pl.polsl.iat.matching.util.Utils;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;
import java.util.stream.Stream;

public class SchemaExtractor {

    public enum Mode {
        LAZY, EAGER;
    }

    private Mode mode = Mode.EAGER;
    private DatabaseMetaData metaData;
    private TableExtractor tableExtractor;
    private String schemaName;
    private ConnectionProperties properties;

    public SchemaExtractor(ConnectionProperties properties) {
        this.properties = properties;
        this.schemaName = properties.getSchemaName();
    }

    public Schema load(Mode exctractionMode) throws SchemaExtractorException {
        SchemaImpl.Builder builder = new SchemaImpl.Builder(mode);
        try {
            SchemaConnection connection = ConnectionFactory.getSchemaConnection(this.properties);
            this.metaData = connection.getMetadata();
            this.tableExtractor = new TableExtractor(metaData, schemaName);
            builder.setName(schemaName);
            builder.setTablesSource(getTables(mode));
            return builder.build();
        } catch (DatabaseException de) {
            throw new SchemaExtractorException(de, "Error extracting schema.");
        }
    }

    public Stream<Table> getTables(SchemaExtractor.Mode extractionMode) throws DatabaseException {
        tableExtractor.setLoaderMode(extractionMode);
        return getTables();
    }

    private Stream<Table> getTables() throws DatabaseException {
        try {
            ResultSet result = metaData.getTables(schemaName, null, null, new String[]{"TABLE"});
            if (Utils.unsafeResultSetNext(result)) {
                return Stream.iterate(prepareTable(result), t -> Utils.unsafeResultSetNext(result), table -> prepareTable(result)).filter(Objects::nonNull);
            }
            return Stream.empty();
        } catch (SQLException e) {
            throw new DatabaseException("Failed to acquire schema tables metadata", e);
        }
    }

    private Table prepareTable(ResultSet tableMetadataRs) {
        try {
            String tableName = tableMetadataRs.getString(Const.ColumnName.GET_TABLES_TABLE_NAME);
            return tableExtractor.load(tableName);
        } catch (Exception e) {
            throw new RuntimeDatabaseException(e);
        }
    }

}
