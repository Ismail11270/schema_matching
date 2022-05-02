package pl.polsl.iat.matching.core.model.schema;

public interface Characteristic<U,T> extends Comparable<BaseCharacteristic<U>>{
    T getValue();
    U getKey();
    CharacteristicType getCharacteristicType();
}
