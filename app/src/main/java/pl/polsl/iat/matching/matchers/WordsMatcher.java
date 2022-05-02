package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.executor.result.PartialResult;

public class WordsMatcher implements Matcher<Words>{

    private WordMatcher stringMatcher;

    public enum Type {
        EXACT, FUZZY, SEMANTIC
    }
    public WordsMatcher(WordMatcher stringMatcher) {
        this.stringMatcher = stringMatcher;
    }
    @Override
    public PartialResult<Words> doMatch(Words left, Words right) {
//        words
        return null;
    }
}
