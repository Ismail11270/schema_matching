package pl.polsl.iat.matching.core.model.schema.impl;

import pl.polsl.iat.matching.core.exception.SchemaExtractorException;
import pl.polsl.iat.matching.core.model.schema.Column;
import pl.polsl.iat.matching.core.model.schema.ColumnCharacteristicType;
import pl.polsl.iat.matching.core.util.Status;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Objects;
import java.util.function.Predicate;
import java.util.function.Supplier;
import java.util.stream.Collectors;

class ColumnsGenerator implements Supplier<Column>, Predicate<Column> {

    private ResultSet columnsRs;

    private Status status = Status.CONTINUE;

    ColumnsGenerator(DatabaseMetaData metaData, String schemaName, String tableName) {
        try {
            this.columnsRs = metaData.getColumns(schemaName, null, tableName, null);
        } catch (SQLException e) {
            throw new SchemaExtractorException("Error generating table objects for schema '" + schemaName + "' Detailed msg: " + e);
        }
    }

    @Override
    public Column get() {
        try {
            if (columnsRs.next()) {
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
            } else {
                this.status = Status.FINISH;
                return null;
            }
        } catch (Exception e) {
            throw new SchemaExtractorException(e);
        }
    }

    @Override
    public boolean test(Column column) {
       return status != Status.FINISH;
    }

}
