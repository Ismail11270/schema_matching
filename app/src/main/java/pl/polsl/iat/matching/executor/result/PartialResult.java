package pl.polsl.iat.matching.executor.result;

import pl.polsl.iat.matching.core.model.schema.Matchable;

public class PartialResult<T extends Matchable> {

    private final Float result;

    public PartialResult(Float f){
        result = f;
    }

    public Float getResult() {
        return result;
    }
}
