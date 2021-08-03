package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.schema.model.Characteristic;
import pl.polsl.iat.matching.schema.model.CharacteristicType;
import pl.polsl.iat.matching.schema.model.Column;
import pl.polsl.iat.matching.schema.model.ColumnCharacteristicType;

public class ColumnCharacteristic implements Characteristic<ColumnCharacteristicType> {

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
    public CharacteristicType getType() {
        return null;
    }

    @Override
    public int compareTo(Characteristic<ColumnCharacteristicType> o) {
        return 0;
    }
}
