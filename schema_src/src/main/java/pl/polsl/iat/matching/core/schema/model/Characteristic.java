package pl.polsl.iat.matching.core.schema.model;

public interface Characteristic<U,T> extends Comparable<BaseCharacteristic<U>>{
    T getValue();
    U getKey();
    CharacteristicType getCharacteristicType();
}
