package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.matchers.result.PartialResult;
import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.processing.Words;

import java.util.Map;

public class WordsMatcher implements Matcher<Words> {

    private final Map<WordMatcher.Type, WordMatcher> stringMatcher;

    WordsMatcher(Map<WordMatcher.Type, WordMatcher> matchers) {
        this.stringMatcher=matchers;
    }

    @Override
    public PartialResult doMatch(Words left, Words right) {
//        words
        //TODO Apply all word matchers
        return null;
    }
}
