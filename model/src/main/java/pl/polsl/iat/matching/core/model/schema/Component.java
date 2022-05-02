package pl.polsl.iat.matching.core.model.schema;

import java.util.stream.Stream;

/**
 *
 *
 * v2 consumed CharacteristicProvider as it proved to be unnecessary
 */
public interface Component extends Matchable {
    String getName();
    Stream<? extends BaseCharacteristic> getCharacteristics();
    ComponentType getComponentType();
}
