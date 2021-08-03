package pl.polsl.iat.matching.schema.model;

import java.util.stream.Stream;

public interface ComponentsProvider<T extends Component> extends CharacteristicProvider {
    //TODO Consider using lists
    Stream<T> getComponents();
}
