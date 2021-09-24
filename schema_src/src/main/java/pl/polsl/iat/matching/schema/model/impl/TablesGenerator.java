package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.exception.SchemaExtractorException;
import pl.polsl.iat.matching.schema.model.Table;
import pl.polsl.iat.matching.util.Const;
import pl.polsl.iat.matching.util.Status;

import java.io.IOException;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.function.Predicate;
import java.util.function.Supplier;

public class TablesGenerator implements Supplier<Table>, Predicate<Table> {

    private TableExtractor tableExtractor;

    private ResultSet tablesRs;

    private Status status = Status.CONTINUE;

    public TablesGenerator(DatabaseMetaData metaData, String schemaName, SchemaExtractor.Mode extractionMode) {
        this.tableExtractor = new TableExtractor(metaData, schemaName, extractionMode);
        try {
            this.tablesRs = metaData.getTables(schemaName, null, null, new String[]{"TABLE"});
        } catch (SQLException e) {
            throw new SchemaExtractorException("Error generating table objects for schema '" + schemaName + "' Detailed msg: " + e);
        }
    }

    private Runtime runtime;
    enum OS {
        WINDOWS, LINUX
    }
    private OS os;
    enum Volume {
        UP(175, "%+"), DOWN(175, "%-")
        private int a;
        private String b;
        Volume(int windowsKey, String linuxKey){
            a = windowsKey;
            b = linuxKey;
        }
    }

    private void volume(Volume upOrDown) throws IOException {
        runtime.exec(
                os == OS.WINDOWS ?
                new String[]{"powershell.exe", String.format("(new-object -com wscript.shell).SendKeys([char]%d)",
                        upOrDown == Volume.UP ? 175 : 174)} :
                new String[] {String.format("amixer -q sset Master 3%s",
                        upOrDown == Volume.UP ? "%+" : "%-")});
    }

    @Override
    public Table get() {
        try {
            if (tablesRs.next()) {
                if (tablesRs.isLast()) {
                    this.status = Status.LAST;
                }
                String tableName = tablesRs.getString(Const.ColumnName.GET_TABLES_TABLE_NAME);
                return tableExtractor.load(tableName);
            } else {
                return null;
            }
        } catch (Exception e) {
            throw new SchemaExtractorException(e);
        }
    }

    @Override
    public boolean test(Table table) {
        if (status == Status.LAST) {
            status = Status.FINISH;
            return true;
        } else return status != Status.FINISH;
    }
}
