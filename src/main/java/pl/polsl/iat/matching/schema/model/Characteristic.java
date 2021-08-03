package pl.polsl.iat.matching.schema.model;

import java.util.Map;

/**
 *
 * @param <U> type of characteristic key - (basic characteristic has characteristic name - string,
 *          {@link Column} characteristic has {@link ColumnCharacteristicType} key type
 */
public interface Characteristic<U> extends Comparable<Characteristic<U>>{
    String getValue();
    U getKey();
    CharacteristicType getType();
}
