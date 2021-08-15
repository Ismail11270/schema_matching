package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.schema.model.BaseCharacteristic;
import pl.polsl.iat.matching.schema.model.CharacteristicType;


/**
 * Characteristic implementation for both key and value types as String
 */
public class StringCharacteristic implements BaseCharacteristic<String> {

    private final CharacteristicType type;
    private final String key;
    private final String value;

    public StringCharacteristic(String charName, String val, CharacteristicType type){
        this.key = charName;
        this.value = val;
        this.type = type;
    }

    @Override
    public String getKey() {
        return key;
    }

    @Override
    public String getValue() {
        return value;
    }

    @Override
    public CharacteristicType getType() {
        return type;
    }

    //TODO IMPLEMENT COMPARETO
    @Override
    public int compareTo(BaseCharacteristic<String> o) {
        return 1;
    }

    @Override
    public String toString() {
        return key + "=" + value;
    }


}
