package pl.polsl.iat.matching.schema.model;

import java.util.stream.Stream;

public interface AttributesProvider extends Component{
    Stream<Attribute<?>> getAttributes();
}