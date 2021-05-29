package pl.polsl.iat.thesis.schema.model.impl;

import pl.polsl.iat.thesis.schema.model.*;
import pl.polsl.iat.thesis.sql.ConnectionProperties;

import java.util.Objects;
import java.util.stream.Stream;

class SchemaImpl implements Schema {
    Stream<Table> tables;

    private SchemaImpl(){

    }

    private SchemaImpl(SchemaImpl schema){

    }

    @Override
    public Stream<Attribute> getAttributes() {
        return null;
    }

    @Override
    public Stream<Component> getComponents() {
        return null;
    }

    static class Builder{
        private final SchemaImpl schema = new SchemaImpl();

        Schema build() {
            return new SchemaImpl(schema);
        }
    }
}
