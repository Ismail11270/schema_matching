package pl.polsl.iat.thesis.schema.model.impl;

import pl.polsl.iat.thesis.schema.model.Column;
import pl.polsl.iat.thesis.schema.model.Constraints;
import pl.polsl.iat.thesis.schema.model.Type;

import java.util.Objects;

class ColumnImpl implements Column {

    private String name;
    private Type type;
    private Constraints constraints;

    ColumnImpl(){

    }

    ColumnImpl(Column col){
        this.name = Objects.requireNonNull(col.getName(), "Column name cannot be null.");
        this.type = Objects.requireNonNullElse(col.getType(), Type.UNKNOWN);
        this.constraints = Objects.requireNonNullElseGet(col.getConstraints(), Constraints::new);
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public Type getType() {
        return type;
    }

    @Override
    public Constraints getConstraints() {
        return constraints;
    }

    static class Builder{
        private ColumnImpl col = new ColumnImpl();
        private String name;
        private Type type;
        private Constraints constraints;

        Builder setName(String name){
            col.name = Objects.requireNonNull(name, "Column name cannot be null.");
            return this;
        }

        Builder setType(Type type){
            col.type = Objects.requireNonNullElse(type, Type.UNKNOWN);
            return this;
        }

        Builder setConstraints(Constraints constraints){
            col.constraints = Objects.requireNonNullElseGet(constraints, Constraints::new);
            return this;
        }

        Column build() {
            return new ColumnImpl(col);
        }
    }
}
