package pl.polsl.iat.matching.matchers.impl;

import pl.polsl.iat.matching.core.model.schema.Column;
import pl.polsl.iat.matching.executor.result.PartialResult;
import pl.polsl.iat.matching.matchers.ColumnMatcher;

public class ColumnMatcherImpl implements ColumnMatcher {
    @Override
    public PartialResult<Column> doMatch(Column left, Column right) {
        return null;
    }
}
