package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.exception.DatabaseException;
import pl.polsl.iat.matching.schema.model.*;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
            builder.addCharacteristics(loadKeyInfo(TableKey.PK, metaData, schema, tableName));
            builder.addCharacteristics(loadKeyInfo(TableKey.FK, metaData, schema, tableName));
            builder.setColumns(Stream.generate(generator).takeWhile(generator));
        } catch (Exception e) {
            throw new DatabaseException("Failed to acquire columns metadata", e);
        }
        return builder.build();
    }

    private List<Characteristic<?, ?>> loadKeyInfo(TableKey key, DatabaseMetaData metaData, String schema, String tableName) throws SQLException {
        ResultSet rs = getRsForKeyType(key, metaData, schema, tableName);
        List<Characteristic<?,?>> chList = new ArrayList<>();
        while (rs.next()){
            chList.add(buildKeyChar(rs, key));
        }

        return chList;
    }

    private KeyCharacteristic buildKeyChar(ResultSet rs, TableKey key) throws SQLException {
        if(key == TableKey.PK) {
            return buildPKChar(rs, key);
         } else {
            return buildFKChar(rs, key);
        }
    }

    private KeyCharacteristic buildFKChar(ResultSet rs, TableKey key) throws SQLException {
        List<BaseCharacteristic<String>> chs = new ArrayList<>();
        for (var chKey : FKCharacteristics.values()) {
            StringCharacteristic sch = new StringCharacteristic(chKey.name(),
                    rs.getString(chKey.name()), FKCharacteristics.getCharacteristicType());
            chs.add(sch);
        }
        return new KeyCharacteristic(key, chs);
    }

    private KeyCharacteristic buildPKChar(ResultSet rs, TableKey key) throws SQLException {
        List<BaseCharacteristic<String>> chs = new ArrayList<>();
        for (var chKey : PKCharacteristics.values()) {
            StringCharacteristic sch = new StringCharacteristic(chKey.name(),
                    rs.getString(chKey.name()), PKCharacteristics.getCharacteristicType());
            chs.add(sch);
        }
        return new KeyCharacteristic(key, chs);
    }

    private ResultSet getRsForKeyType(TableKey key, DatabaseMetaData metaData, String schema, String table) throws SQLException {
        if(key == TableKey.FK) {
            return metaData.getImportedKeys(schema, null, table);
        } else {
            return metaData.getPrimaryKeys(schema, null, table);
        }
    }
}
