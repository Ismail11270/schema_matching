package pl.polsl.iat.matching.core.schema.model;

import java.util.List;

public interface ComponentsProvider<T extends Component> extends Component {
    List<T> getComponents();
}
