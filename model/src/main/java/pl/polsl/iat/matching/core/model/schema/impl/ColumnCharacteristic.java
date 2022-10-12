package pl.polsl.iat.matching.core.model.schema.impl;

import pl.polsl.iat.matching.core.model.schema.BaseCharacteristic;
import pl.polsl.iat.matching.core.model.schema.CharacteristicType;
import pl.polsl.iat.matching.core.model.schema.ColumnCharacteristicType;

public class ColumnCharacteristic implements BaseCharacteristic<ColumnCharacteristicType> {


    private ColumnCharacteristicType key;
    private String value;

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
        return key.getGeneralType();
    }

    @Override
    public String toString() {
        return key + "=" + value;
    }
}
