package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.exception.RuntimeDatabaseException;
import pl.polsl.iat.matching.exception.SchemaExtractorException;
import pl.polsl.iat.matching.schema.model.Column;
import pl.polsl.iat.matching.schema.model.ColumnCharacteristicType;
import pl.polsl.iat.matching.util.Const;
import pl.polsl.iat.matching.util.Status;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Objects;
import java.util.function.Predicate;
import java.util.function.Supplier;

public class ColumnsGenerator implements Supplier<Column>, Predicate<Column> {

    private ResultSet columnsRs;

    private Status status = Status.CONTINUE;

    public ColumnsGenerator(DatabaseMetaData metaData, String schemaName, String tableName) {
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
                if (columnsRs.isLast()) {
                    this.status = Status.LAST;
                }
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
                return null;
            }
        } catch (Exception e) {
            throw new SchemaExtractorException(e);
        }
    }

    @Override
    public boolean test(Column column) {
        if (status == Status.LAST) {
            status = Status.FINISH;
            return true;
        } else return status != Status.FINISH;
    }

}
