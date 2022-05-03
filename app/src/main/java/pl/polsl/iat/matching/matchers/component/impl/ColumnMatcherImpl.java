package pl.polsl.iat.matching.matchers.component.impl;

import pl.polsl.iat.matching.core.model.schema.Column;
import pl.polsl.iat.matching.matchers.result.PartialResult;
import pl.polsl.iat.matching.matchers.component.ColumnMatcher;

class ColumnMatcherImpl implements ColumnMatcher {
    @Override
    public PartialResult<Column> doMatch(Column left, Column right) {
        return null;
    }
}
