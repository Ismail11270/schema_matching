package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.schema.model.*;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class ColumnImpl implements Column {

    private static final ComponentType type = ComponentType.COLUMN;

    private String name;
    private Stream<ColumnCharacteristic> characteristics;
    private List<ColumnCharacteristic> chrs;
    ColumnImpl(){

    }

    ColumnImpl(Column col, Stream<ColumnCharacteristic> characteristics){
        this.name = Objects.requireNonNull(col.getName(), "Column name cannot be null.");
        this.characteristics = Objects.requireNonNull(characteristics);
    }

    @Override
    public Stream<ColumnCharacteristic> getCharacteristics() {
        return characteristics;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return getName();
    }

    @Override
    public ComponentType getComponentType() {
        return type;
    }

    static class Builder{
        private final ColumnImpl col = new ColumnImpl();

        Builder setName(String name) {
            col.name = Objects.requireNonNull(name, "Column name cannot be null.");
            return this;
        }

        Builder setCharacteristics(Stream<ColumnCharacteristic> characteristics){
            col.characteristics = characteristics;
            col.chrs = characteristics.collect(Collectors.toList());
            return this;
        }

        Column build() {
            return col;
        }
    }
}
