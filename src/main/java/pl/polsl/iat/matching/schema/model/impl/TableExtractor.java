package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.exception.DatabaseException;
import pl.polsl.iat.matching.exception.RuntimeDatabaseException;
import pl.polsl.iat.matching.schema.model.Column;
import pl.polsl.iat.matching.schema.model.ColumnCharacteristicType;
import pl.polsl.iat.matching.schema.model.Table;
import pl.polsl.iat.matching.util.Utils;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Objects;
import java.util.stream.Stream;

public class TableExtractor {

    private DatabaseMetaData metaData;
    private String schema;
    private SchemaExtractor.Mode loaderMode = SchemaExtractor.Mode.EAGER;

    public TableExtractor(DatabaseMetaData metadata, String schema) {
        this.metaData = metadata;
        this.schema = schema;
    }

    public TableExtractor(DatabaseMetaData metaData, String schema, SchemaExtractor.Mode loaderMode) {
        this(metaData, schema);
        this.loaderMode = loaderMode;
    }

    public Table load(String tableName) throws DatabaseException {
        TableImpl.Builder builder = new TableImpl.Builder(loaderMode);
        try {
            builder.setName(tableName);
            ColumnsGenerator generator = new ColumnsGenerator(metaData, schema, tableName);
            builder.setColumns(Stream.generate(generator).takeWhile(generator));
        } catch (Exception e) {
            throw new DatabaseException("Failed to acquire columns metadata", e);
        }
        return builder.build();
    }

}
