package pl.polsl.iat.matching.executor.result;

import pl.polsl.iat.matching.core.schema.model.Component;

public class PartialResult<T extends Component> {

    private final Float result;

    public PartialResult(Float f){
        result = f;
    }

    public Float getResult() {
        return result;
    }
}
