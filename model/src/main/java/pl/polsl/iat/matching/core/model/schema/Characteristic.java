package pl.polsl.iat.matching.core.model.schema;

public interface Characteristic<U,T> extends Matchable{
    T getValue();
    U getKey();
    CharacteristicType getCharacteristicType();
}
