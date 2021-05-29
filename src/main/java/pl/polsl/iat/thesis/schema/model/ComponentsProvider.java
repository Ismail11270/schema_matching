package pl.polsl.iat.thesis.schema.model;

import java.util.stream.Stream;

public interface ComponentsProvider extends AttributesProvider {
    Stream<Component> getComponents();
}
