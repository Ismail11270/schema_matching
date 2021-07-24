package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.schema.model.*;

import java.util.stream.Stream;

class SchemaImpl implements Schema {
    private Stream<Table> tables;
    private int tablesN;

    private SchemaImpl(){

    }

    private SchemaImpl(SchemaImpl schema){
        this.tablesN = schema.tablesN;
        this.tables = schema.tables;
    }

    @Override
    public Stream<Attribute<?>> getAttributes() {
        return null;
    }

    @Override
    public Stream<Component> getComponents() {
        return null;
    }

    static class Builder{
        private final SchemaImpl schema = new SchemaImpl();

        public void setNumberOfTables(int n){
            schema.tablesN = n;
        }

        public void setTablesSource(Stream<Table> tableStream){
            schema.tables = tableStream;
        }

        Schema build() {
            return new SchemaImpl(schema);
        }
    }
}
