package pl.polsl.iat.matching.core.model.schema;

import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

/**
 *
 *
 * v2 consumed CharacteristicProvider as it proved to be unnecessary
 */
public interface Component extends Matchable {
    String getName();
    Map<? extends Object, ? extends BaseCharacteristic<?>> getCharacteristics();
    ComponentType getComponentType();
}
