package pl.polsl.iat.matching.schema.model;

import java.util.stream.Stream;

/**
 *
 *
 * v2 consumed CharacteristicProvider as it proved to be unnecessary
 */
public interface Component {
    String getName();
    Stream<? extends BaseCharacteristic> getCharacteristics();
}
