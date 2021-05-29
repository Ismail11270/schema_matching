package pl.polsl.iat.thesis.schema.model.impl;

import pl.polsl.iat.thesis.schema.model.Attribute;
import pl.polsl.iat.thesis.schema.model.Column;
import pl.polsl.iat.thesis.schema.model.Constraints;
import pl.polsl.iat.thesis.schema.model.ColumnType;

import java.util.Objects;
import java.util.function.Supplier;
import java.util.stream.Stream;

class ColumnImpl implements Column {

    private String name;
    private ColumnType type;
    private Constraints constraints;
    private Supplier<Attribute> attributesSupplier;

    ColumnImpl(){

    }

    ColumnImpl(Column col, Supplier<Attribute> supplier){
        this.name = Objects.requireNonNull(col.getName(), "Column name cannot be null.");
        this.type = Objects.requireNonNullElse(col.getType(), ColumnType.UNKNOWN);
        this.constraints = Objects.requireNonNullElseGet(col.getConstraints(), Constraints::new);
        this.attributesSupplier = Objects.requireNonNull(supplier);
    }

    @Override
    public Stream<Attribute> getAttributes() {
        return Stream.generate(attributesSupplier);
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public ColumnType getType() {
        return type;
    }

    @Override
    public Constraints getConstraints() {
        return constraints;
    }

    static class Builder{
        private final ColumnImpl col = new ColumnImpl();
        private Supplier<Attribute> suppl;

        Builder setName(String name){
            col.name = Objects.requireNonNull(name, "Column name cannot be null.");
            return this;
        }

        Builder setType(ColumnType type){
            col.type = Objects.requireNonNullElse(type, ColumnType.UNKNOWN);
            return this;
        }

        Builder setConstraints(Constraints constraints){
            col.constraints = Objects.requireNonNullElseGet(constraints, Constraints::new);
            return this;
        }

        Builder setAttributesSupplier(Supplier<Attribute> attributesSupplier){
            this.suppl = attributesSupplier;
            return this;
        }
        Column build() {
            return new ColumnImpl(col, suppl);
        }
    }
}
