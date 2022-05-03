package pl.polsl.iat.matching.matchers.component.impl;

import pl.polsl.iat.matching.core.model.schema.Table;
import pl.polsl.iat.matching.matchers.result.PartialResult;
import pl.polsl.iat.matching.matchers.component.ColumnMatcher;
import pl.polsl.iat.matching.matchers.component.TableMatcher;

class TableMatcherImpl implements TableMatcher {
    private final ColumnMatcher columnMatcher = new ColumnMatcherImpl();

    public TableMatcherImpl() {

    }

    @Override
    public PartialResult<Table> doMatch(Table left, Table right) {
        return null;
    }
}
