package pl.polsl.iat.matching.schema.model;

import java.util.stream.Stream;

public interface ComponentsProvider extends AttributesProvider {
    Stream<? extends Component> getComponents();
}
