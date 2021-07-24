package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.schema.model.*;

import java.util.stream.Stream;

class TableImpl implements Table {

    private String name;
    private int columnN;
    private Schema parentComponent;
    private Stream<Column> columns;

    private Stream<Attribute<?>> attributesSource;

    private TableImpl(){

    }

    //TODO
    @Override
    public Stream<Attribute<?>> getAttributes() {
        return attributesSource;
    }

    //TODO
    @Override
    public Stream<? extends Component> getComponents() {
        return columns;
    }

    @Override
    public ComponentsProvider getParentComponent() {
        return parentComponent;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public int getColumnsNumber() {
        return columnN;
    }


    public static class Builder{
        private final TableImpl table = new TableImpl();

        public Builder setParent(Schema parentComponent){
            table.parentComponent = parentComponent;
            return this;
        }

        public Builder setName(String name){
            table.name = name;
            return this;
        }

        public Builder setColumnsNumber(int columnsN){
            table.columnN = columnsN;
            return this;
        }

        public Builder setColumns(Stream<Column> columnsSource){
            table.columns = columnsSource;
            return this;
        }

        Table build() {
            return table;
        }
    }
}
