package pl.polsl.iat.matching.matchers.impl;

import pl.polsl.iat.matching.matchers.ColumnMatcher;
import pl.polsl.iat.matching.matchers.TableMatcher;

public class TableMatcherImpl implements TableMatcher {
    private final ColumnMatcher columnMatcher = new ColumnMatcherImpl();

    public TableMatcherImpl() {

    }
}
