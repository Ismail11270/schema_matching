package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.executor.result.PartialResult;

public abstract class WordMatcher implements Matcher<Word>{
    public enum Type {
        EXACT(0), FUZZY(1), DICTIONARY(2);
        private final int id;

        Type(int id){
            this.id = id;
        }

        public String getName(){
            return this.getName().toLowerCase();
        }
    }

    public static WordMatcher getMatherOfType(Type type) {
        return new WordMatcher() {
            @Override
            public PartialResult<Word> doMatch(Word left, Word right) {
                return null;
            }
        };
    }

}
