package pl.polsl.iat.matching.core.model.schema.impl;

import com.sun.jdi.ArrayReference;
import pl.polsl.iat.matching.core.exception.SchemaExtractorException;
import pl.polsl.iat.matching.core.model.schema.*;
import pl.polsl.iat.matching.core.util.Status;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.function.Predicate;
import java.util.function.Supplier;
import java.util.stream.Stream;

class ColumnsGenerator implements Supplier<Column>, Predicate<Column> {

    private ResultSet columnsRs;

    private Status status = Status.CONTINUE;

    private final List<KeyCharacteristic> primaryKeyCh, foreignKeyCh;

    ColumnsGenerator(DatabaseMetaData metaData, String schemaName, String tableName, List<KeyCharacteristic> primaryKeyCh, List<KeyCharacteristic> foreignKeyCh) {
        try {
            this.columnsRs = metaData.getColumns(schemaName, null, tableName, null);
        } catch (SQLException e) {
            throw new SchemaExtractorException("Error generating table objects for schema '" + schemaName + "' Detailed msg: " + e);
        }
        this.primaryKeyCh = primaryKeyCh;
        this.foreignKeyCh = foreignKeyCh;
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
                String columnName = columnsRs.getString(ColumnCharacteristicType.COLUMN_NAME.name());
                columnBuilder.setName(columnName);
                List<ColumnCharacteristic> keyChs = new ArrayList<>();
                if(primaryKeyCh
                        .stream()
                        .map(pkCh -> pkCh.getChildValue("COLUMN_NAME"))
                        .filter(Predicate.not(String::isBlank))
                        .toList().contains(columnName)) {
                    keyChs.add(new ColumnCharacteristic(ColumnCharacteristicType.PRIMARY_KEY, Boolean.TRUE.toString()));
                } else {
                    keyChs.add(new ColumnCharacteristic(ColumnCharacteristicType.PRIMARY_KEY, Boolean.FALSE.toString()));
                }
                if(foreignKeyCh
                        .stream()
                        .map(pkCh -> pkCh.getChildValue("FK_COLUMN_NAME"))
                        .filter(Predicate.not(String::isBlank))
                        .toList().contains(columnName)) {
                    keyChs.add(new ColumnCharacteristic(ColumnCharacteristicType.FOREIGN_KEY, Boolean.TRUE.toString()));
                } else {
                    keyChs.add(new ColumnCharacteristic(ColumnCharacteristicType.FOREIGN_KEY, Boolean.FALSE.toString()));
                }
                if(!keyChs.isEmpty())
                    charStream = Stream.concat(charStream, keyChs.stream());
                columnBuilder.setCharacteristics(charStream);
//                if(columnName.equals())
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
