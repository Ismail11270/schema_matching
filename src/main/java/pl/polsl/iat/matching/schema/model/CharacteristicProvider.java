package pl.polsl.iat.matching.schema.model;

import java.util.stream.Stream;

public interface CharacteristicProvider extends Component{
    Stream<? extends Characteristic> getCharacteristics();
}
