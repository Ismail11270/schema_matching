package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.executor.result.PartialResult;

public abstract class WordMatcher implements Matcher<Word>{
    public enum Type {
        EXACT, FUZZY,
    }
}
