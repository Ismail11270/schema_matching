package pl.polsl.iat.matching.impl;

import pl.polsl.iat.matching.result.MatchingComponent;
import pl.polsl.iat.matching.schema.model.Schema;

public class SchemaMatcher extends ComponentMatcher<Schema> {

    public SchemaMatcher(Schema left, Schema right, MatchingComponent rMatchingComponent) {
        super(left, right, rMatchingComponent);
    }

//    @Override
//    public float doMatch(Schema left, Schema right, MatchingComponent matchingComponent) {
//
//        return stringMatcher.compare(new StringPair(left.getName(), right.getName()));
//    }
}
