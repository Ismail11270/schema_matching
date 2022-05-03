package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.processing.Word;

public abstract class WordMatcher implements Matcher<Word> {
    public enum Type {
        EXACT(0) {
            @Override
            WordMatcher getMatcher() {
                return new ExactMatcher();
            }
        }, FUZZY(1) {
            @Override
            WordMatcher getMatcher() {
                return new FuzzyMatcher();
            }
        }, SEMANTIC(2) {
            @Override
            WordMatcher getMatcher() {
                return new SemanticMather();
            }
        };

        private final int id;

        Type(int id) {
            this.id = id;
        }

        abstract WordMatcher getMatcher();

        public String getName() {
            return this.getName().toLowerCase();
        }
    }

}
