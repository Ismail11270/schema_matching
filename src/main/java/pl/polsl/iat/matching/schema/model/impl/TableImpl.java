package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.exception.SchemaExtractorException;
import pl.polsl.iat.matching.schema.model.*;
import pl.polsl.iat.matching.util.Const;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class TableImpl implements Table {

    private int columnN;
    private Stream<Column> columnsStream;
    private List<Column> columnsList;
    private List<Characteristic<?>> characteristics;
    private BasicCharacteristic tableName;
    private boolean loaded;

    private TableImpl(){

    }

    //TODO
    @Override
    public Stream<Characteristic<?>> getCharacteristics() {
        return characteristics.stream();
    }

    //TODO
    @Override
    public Stream<Column> getComponents() {
        return columnsStream;
    }

    @Override
    public String getName() {
        return tableName.getValue();
    }

    @Override
    public int getColumnsNumber() {
        return columnN;
    }


    public static class Builder{
        private final TableImpl table = new TableImpl();

        private SchemaExtractor.Mode loaderMode;

        public Builder(SchemaExtractor.Mode loaderMode){
            this.loaderMode = loaderMode;
        }

        public Builder setName(String name){
            table.tableName = new BasicCharacteristic(Const.CharName.TABLE_NAME, name, CharacteristicType.Name);
            return this;
        }

        public Builder setColumns(Stream<Column> columnsSource){
            if(loaderMode == SchemaExtractor.Mode.LAZY){
                table.columnsStream = columnsSource;
            } else {
                table.columnsList = columnsSource.collect(Collectors.toList());
                table.loaded = true;
            }
            return this;
        }

        public Table build() {
            if(table.columnsList == null && table.columnsStream == null){
                throw new SchemaExtractorException("Table data now provided for schema");
            }
            if(table.tableName == null) {
                throw new SchemaExtractorException("Schema name is missing");
            }
            return table;
        }
    }
}
