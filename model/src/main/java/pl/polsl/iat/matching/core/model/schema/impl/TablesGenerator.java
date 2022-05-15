package pl.polsl.iat.matching.core.model.schema.impl;

import pl.polsl.iat.matching.core.exception.SchemaExtractorException;
import pl.polsl.iat.matching.core.model.schema.Table;
import pl.polsl.iat.matching.core.util.Const;
import pl.polsl.iat.matching.core.util.Status;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.function.Predicate;
import java.util.function.Supplier;

class TablesGenerator implements Supplier<Table>, Predicate<Table> {

    private TableExtractor tableExtractor;

    private ResultSet tablesRs;

    private Status status = Status.CONTINUE;

    TablesGenerator(DatabaseMetaData metaData, String schemaName, SchemaExtractor.Mode extractionMode) {
        this.tableExtractor = new TableExtractor(metaData, schemaName, extractionMode);
        try {
            this.tablesRs = metaData.getTables(schemaName, null, null, new String[]{"TABLE"});
        } catch (SQLException e) {
            throw new SchemaExtractorException("Error generating table objects for schema '" + schemaName + "' Detailed msg: " + e);
        }
    }

    @Override
    public Table get() {
        try {
            if (tablesRs.next()) {
                String tableName = tablesRs.getString(Const.ColumnName.GET_TABLES_TABLE_NAME);
                return tableExtractor.load(tableName);
            } else {
                this.status = Status.FINISH;
                return null;
            }
        } catch (Exception e) {
            throw new SchemaExtractorException(e);
        }
    }

    @Override
    public boolean test(Table table) {
        return status != Status.FINISH;
    }
}
