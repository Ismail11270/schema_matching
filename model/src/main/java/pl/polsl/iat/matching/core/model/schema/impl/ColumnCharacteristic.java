package pl.polsl.iat.matching.core.model.schema.impl;

import pl.polsl.iat.matching.core.model.schema.BaseCharacteristic;
import pl.polsl.iat.matching.core.model.schema.CharacteristicType;
import pl.polsl.iat.matching.core.model.schema.ColumnCharacteristicType;

public class ColumnCharacteristic implements BaseCharacteristic<ColumnCharacteristicType> {


    private ColumnCharacteristicType key;
    private String value;
    private CharacteristicType type;

    public ColumnCharacteristic(ColumnCharacteristicType key, String value){
        this.key = key;
        this.value = value;
    }

    @Override
    public String getValue() {
        return value;
    }

    @Override
    public ColumnCharacteristicType getKey() {
        return key;
    }

    @Override
    public CharacteristicType getCharacteristicType() {
        return null;
    }

    @Override
    public int compareTo(BaseCharacteristic<ColumnCharacteristicType> o) {
        return 0;
    }

    @Override
    public String toString() {
        return key + "=" + value;
    }
}
