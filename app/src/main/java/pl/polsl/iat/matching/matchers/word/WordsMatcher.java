package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.matchers.result.WordsMatchingResult;
import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.processing.Words;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.Map;
import java.util.stream.Collectors;

public class WordsMatcher implements Matcher<Words, WordsMatchingResult> {

    private final Map<WordMatcher.Type, WordMatcher> stringMatcher;

    WordsMatcher(Map<WordMatcher.Type, WordMatcher> matchers) {
        this.stringMatcher=matchers;
    }

    private Map<WordMatcher.Type, WordMatcher> availableWordMatchers = MatcherSettings.getSettings().getAvailableWordMatchers();

    @Override
    public WordsMatchingResult doMatch(Words left, Words right) {
        WordsMatchingResult result = new WordsMatchingResult();
        //TODO Apply all word matchers
        // add a map of results in the result type and a method to calculate a combined score using weight of each matcher
        for (WordMatcher.Type typeMatcher : availableWordMatchers.entrySet().stream().map(e -> e.getKey()).collect(Collectors.toList())) {
            result.addResult(typeMatcher, matchWords(typeMatcher.getMatcher(), left, right));
        }
        return result;
    }

    private float matchWords(WordMatcher matcher, Words left, Words right) {
        left.get().forEach(word -> {
            right.get().forEach(word2 -> {
                WordsMatchingResult result = matcher.doMatch(word, word2);
                if (result != null) {
//                    return result;
                }
            });
        });
        return 0;
    }

}
