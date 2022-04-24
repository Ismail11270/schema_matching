package pl.polsl.iat.matching.schema.model;

public interface Characteristic<U,T> extends Comparable<BaseCharacteristic<U>>{
    T getValue();
    U getKey();
    CharacteristicType getCharacteristicType();
}
