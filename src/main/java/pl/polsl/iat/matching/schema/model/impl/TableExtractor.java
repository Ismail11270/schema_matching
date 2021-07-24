package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.schema.model.Table;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;

public class TableExtractor {

    private DatabaseMetaData metaData;

    public TableExtractor(DatabaseMetaData metadata) {
        this.metaData = metadata;
    }

    public Table load(ResultSet r){
        TableImpl.Builder builder = new TableImpl.Builder();
        
        return builder.build();
    }

}
