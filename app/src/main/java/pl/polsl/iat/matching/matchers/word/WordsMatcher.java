package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.matchers.result.WordMatchingResult;
import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.processing.Words;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.Map;

public class WordsMatcher implements Matcher<Words, WordMatchingResult> {

    private final Map<WordMatcher.Type, WordMatcher> stringMatcher;

    WordsMatcher(Map<WordMatcher.Type, WordMatcher> matchers) {
        this.stringMatcher=matchers;
    }

    private Map<WordMatcher.Type, WordMatcher> availableWordMatchers = MatcherSettings.getSettings().getAvailableWordMatchers();

    @Override
    public WordMatchingResult doMatch(Words left, Words right) {
//        words
        //TODO Apply all word matchers
        for (Map.Entry<WordMatcher.Type, WordMatcher> typeMatcher : availableWordMatchers.entrySet()) {
//            typeMatcher.
        }
        return new WordMatchingResult(left.equals(right) ? 100f : 0f);
    }
}
