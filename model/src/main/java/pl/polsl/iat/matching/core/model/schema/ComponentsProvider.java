package pl.polsl.iat.matching.core.model.schema;

import java.util.List;

public interface ComponentsProvider<T extends Component> extends Component {
    List<T> getComponents();
}
