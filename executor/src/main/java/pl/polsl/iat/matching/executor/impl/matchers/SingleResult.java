package pl.polsl.iat.matching.executor.impl.matchers;

import pl.polsl.iat.matching.result.ResultComponentType;

public class SingleResult {
    private float match;

    private ResultComponentType type;

    private StringTuple componentNames;

    public SingleResult(ResultComponentType type, String firstName, String secondName) {
        this.type = type;
        this.componentNames = new StringTuple(firstName, secondName);
    }
}
