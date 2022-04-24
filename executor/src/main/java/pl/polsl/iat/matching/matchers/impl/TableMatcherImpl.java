package pl.polsl.iat.matching.matchers.impl;

import pl.polsl.iat.matching.matchers.ColumnMatcher;
import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.matchers.TableMatcher;
import pl.polsl.iat.matching.schema.model.ComponentType;
import pl.polsl.iat.matching.schema.model.Table;

import java.util.TreeMap;

public class TableMatcherImpl implements TableMatcher {
    private final ColumnMatcher columnMatcher = new ColumnMatcherImpl();

    public TableMatcherImpl() {

    }
}
