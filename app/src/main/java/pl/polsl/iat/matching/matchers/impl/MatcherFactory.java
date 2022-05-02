package pl.polsl.iat.matching.matchers.impl;

import pl.polsl.iat.matching.core.model.schema.Component;
import pl.polsl.iat.matching.core.model.schema.ComponentType;
import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.matchers.Word;
import pl.polsl.iat.matching.matchers.WordMatcher;

import java.util.Map;

public class MatcherFactory {

    public enum WordMatcherType {
        EXACT,
    }
    private static Map<ComponentType, Matcher<? extends Component>> componentMatchersCache;
    private static Map<WordMatcher.Type, Matcher<Word>> wordMatchersCache;
//    private static Map<>
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
}
