package pl.polsl.iat.matching.impl;

import pl.polsl.iat.matching.result.MatchingComponent;
import pl.polsl.iat.matching.schema.model.Table;

public class TableMatcher extends ComponentMatcher<Table> {
    public TableMatcher(Table left, Table right, MatchingComponent rMatchingComponent) {
        super(left, right, rMatchingComponent);
    }

//    @Override
//    public float doMatch(Table left, Table right, MatchingComponent matchingComponent) {
//        return 0;
//    }
}