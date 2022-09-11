package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.matchers.result.WordsMatchingResult;
import pl.polsl.iat.matching.processing.Word;

public abstract class WordMatcher implements Matcher<Word, Integer> {

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

}
