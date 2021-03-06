package pl.polsl.iat.matching.core.model.schema;

/**
 *
 * @param <U> type of characteristic key - (basic characteristic has characteristic name - string,
 *          {@link Column} characteristic has {@link ColumnCharacteristicType} key type
 */
public interface BaseCharacteristic<U> extends Characteristic<U,String>{
    String getValue();
    U getKey();
    CharacteristicType getCharacteristicType();

}
