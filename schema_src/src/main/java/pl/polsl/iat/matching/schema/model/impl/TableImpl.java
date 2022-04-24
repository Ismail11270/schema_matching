package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.exception.SchemaExtractorException;
import pl.polsl.iat.matching.schema.model.*;
import pl.polsl.iat.matching.util.Const;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class TableImpl implements Table {
    private static final ComponentType type = ComponentType.TABLE;
    private int columnN;
    private Stream<Column> columnsStream;
    private List<Column> columnsList;
    private StringCharacteristic tableName;

    private Set<Characteristic<?,?>> characteristics = new HashSet<>();

    private boolean loaded;

    @Override
    public Stream<BaseCharacteristic<?>> getCharacteristics() {
        return Stream.of(tableName);
    }

    private void loadComponents() {
        if(!loaded){
            columnsList = columnsStream.collect(Collectors.toList());
            loaded = true;
        }
    }

    @Override
    public List<Column> getComponents() {
        loadComponents();
        return columnsList;
    }

    @Override
    public String getName() {
        return tableName.getValue();
    }

    @Override
    public int getColumnsNumber() {
        return columnN;
    }

    @Override
    public String toString(){
        return "TableName=" + tableName.getValue();
    }

    @Override
    public ComponentType getComponentType() {
        return type;
    }

    public static class Builder{
        private final TableImpl table = new TableImpl();

        private SchemaExtractor.Mode loaderMode;

        public Builder(SchemaExtractor.Mode loaderMode){
            this.loaderMode = loaderMode;
        }

        public Builder setName(String name){
            table.tableName = new StringCharacteristic(Const.CharName.TABLE_NAME, name, CharacteristicType.TableName);
            table.characteristics.add(table.tableName);
            return this;
        }

        public Builder addCharacteristics(List<Characteristic<?,?>> chList){
            table.characteristics.addAll(chList);
            return this;
        }

        public Builder addCharacteristic(Characteristic<?,?> ch){
            table.characteristics.add(ch);
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

        public Builder setColumns(List<Column> columnsList){
            table.loaded = true;
            table.columnsList = columnsList;
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
