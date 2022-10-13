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
    public int match(BaseCharacteristic<?> o) {
        if(value == null || o.getValue() == null) {
            return 0;
        }
        if(key == ColumnCharacteristicType.FOREIGN_KEY || key == ColumnCharacteristicType.PRIMARY_KEY) {
            boolean left = Boolean.parseBoolean(value);
            boolean right = Boolean.parseBoolean(o.getValue());
            return left && right ? 1 : !left && !right ? 0 : -1;
        } else {
            return value.equals(o.getValue()) ? 1 : -1;
        }
    }

    @Override
    public String toString() {
        return key + "=" + value;
    }
}
