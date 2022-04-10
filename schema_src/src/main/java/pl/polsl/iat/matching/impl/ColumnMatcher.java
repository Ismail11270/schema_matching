package pl.polsl.iat.matching.impl;

import pl.polsl.iat.matching.result.MatchingComponent;
import pl.polsl.iat.matching.schema.model.Column;

public class ColumnMatcher extends ComponentMatcher<Column> {
    public ColumnMatcher(Column left, Column right, MatchingComponent rMatchingComponent) {
        super(left, right, rMatchingComponent);
    }

//    @Override
//    public float doMatch(MatchingComponent matchingComponent) {
//        return 0;
//    }
}
