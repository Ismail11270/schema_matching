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

    public TableExtractor(DatabaseMetaData metaData, String schema, SchemaExtractor.Mode loaderMode){
        this(metaData,schema);
        this.loaderMode = loaderMode;
    }

    public void setLoaderMode(SchemaExtractor.Mode mode) {
        loaderMode = mode;
    }

    public Table load(String tableName) throws DatabaseException {
        TableImpl.Builder builder = new TableImpl.Builder(loaderMode);
        try {
            builder.setName(tableName);
            ResultSet columnsRs = metaData.getColumns(schema, null, tableName, null);
            if (Utils.unsafeResultSetNext(columnsRs)) {
                builder.setColumns(Stream.iterate(prepareColumn(columnsRs), t -> Utils.unsafeResultSetNext(columnsRs), table -> prepareColumn(columnsRs)).filter(Objects::nonNull));
            } else {
                builder.setColumns(Stream.empty());
            }
        } catch (Exception e) {
            throw new DatabaseException("Failed to acquire columns metadata", e);
        }
        return builder.build();
    }

    private Column prepareColumn(ResultSet columnsRs) {
        try {
            var columnBuilder = new ColumnImpl.Builder();
            var charStream = Arrays.stream(ColumnCharacteristicType.values()).map(column -> {
                try {
                    String colVal = columnsRs.getString(column.name());
                    var colChar = new ColumnCharacteristic(column, colVal);
                    return colChar;
                } catch (SQLException throwables) {
                    return null;
                }
            }).filter(Objects::nonNull);
            columnBuilder.setCharacteristics(charStream);
            columnBuilder.setName(columnsRs.getString(ColumnCharacteristicType.COLUMN_NAME.name()));
            return columnBuilder.build();
        } catch (Exception e) {
            throw new RuntimeDatabaseException(e);
        }
    }

}
