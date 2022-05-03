package pl.polsl.iat.matching.matchers.component.impl;

import pl.polsl.iat.matching.core.model.schema.Component;
import pl.polsl.iat.matching.core.model.schema.ComponentType;
import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.matchers.component.ColumnMatcher;
import pl.polsl.iat.matching.matchers.component.SchemaMatcher;
import pl.polsl.iat.matching.matchers.component.TableMatcher;

import java.util.Map;

public class ComponentMatcherFactory {

    private static Map<ComponentType, Matcher<? extends Component>> componentMatchersCache;

    public static Map<ComponentType, Matcher<? extends Component>> getComponentMatchers() {
        initComponentMatchers();
        return componentMatchersCache;
    }

    private static void initComponentMatchers() {
        componentMatchersCache = componentMatchersCache != null ? componentMatchersCache :
                Map.of(
                        ComponentType.SCHEMA, new SchemaMatcherImpl(),
                        ComponentType.TABLE, new TableMatcherImpl(),
                        ComponentType.COLUMN, new ColumnMatcherImpl());
    }

    public static TableMatcher getTableMatcher() {
        return (TableMatcher) componentMatchersCache.get(ComponentType.TABLE);
    }

    public static SchemaMatcher getSchemaMather() {
        return (SchemaMatcher) componentMatchersCache.get(ComponentType.SCHEMA);
    }

    public static ColumnMatcher getColumnMatcher() {
        return (ColumnMatcher) componentMatchersCache.get(ComponentType.COLUMN);
    }


}
