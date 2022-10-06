package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.matchers.result.WordsMatchingResult;
import pl.polsl.iat.matching.processing.Word;

import java.util.HashMap;
import java.util.Map;

public abstract class WordMatcher implements Matcher<Word, Integer> {

    private final Map<String, Object> matcherOptions = new HashMap<>();

    public enum Type {
        EXACT(0) {
            @Override
            WordMatcher getMatcher() { return ExactMatcher.getInstance(); }
        }, FUZZY(1) {
            @Override
            WordMatcher getMatcher() { return FuzzyMatcher.getInstance(); }
        }, SEMANTIC(2) {
            @Override
            WordMatcher getMatcher() { return SemanticMather.getInstance(); }
        };

        private final int id;

        Type(int id) {
            this.id = id;
        }

        abstract WordMatcher getMatcher();

        public String getName() {
            return name().toLowerCase();
        }

        public int getPriority() {
            return id;
        }

    }

    public static class Options {
        public static class Fuzzy {
            public static final String METHOD = "method";
        }
    }

    public void addOption(String key, Object value) {
        matcherOptions.put(key, value);
    }

    public Object getOption(String key) {
        return matcherOptions.get(key);
    }

    public abstract Type getType();
}
