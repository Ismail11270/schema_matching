package pl.polsl.iat.matching.core.model.schema.impl;

import pl.polsl.iat.matching.core.model.schema.Column;
import pl.polsl.iat.matching.core.model.schema.ColumnCharacteristicType;
import pl.polsl.iat.matching.core.model.schema.ComponentType;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class ColumnImpl implements Column {

    private static final ComponentType type = ComponentType.COLUMN;

    private String name;
    private Map<ColumnCharacteristicType, ColumnCharacteristic> characteristicsMap;
    ColumnImpl(){

    }

    @Override
    public Map<ColumnCharacteristicType, ColumnCharacteristic> getCharacteristics() {
        return characteristicsMap;
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
            col.characteristicsMap = characteristics.collect(Collectors.toMap(ColumnCharacteristic::getKey, x->x));
            return this;
        }

        Column build() {
            return col;
        }
    }
}
