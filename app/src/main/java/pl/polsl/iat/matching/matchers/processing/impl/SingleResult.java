package pl.polsl.iat.matching.matchers.processing.impl;

import pl.polsl.iat.matching.matchers.processing.StringPair;
import pl.polsl.iat.matching.core.model.result.ResultComponentType;

public class SingleResult {
    private float match;

    private ResultComponentType type;

    private StringPair componentNames;

    public SingleResult(ResultComponentType type, String firstName, String secondName) {
        this.type = type;
        this.componentNames = new StringPair(firstName, secondName);
    }
}
