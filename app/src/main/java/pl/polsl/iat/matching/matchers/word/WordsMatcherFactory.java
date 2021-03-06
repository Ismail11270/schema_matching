package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

public class WordsMatcherFactory {

    private static Map<WordMatcher.Type,WordMatcher> wordMatchersCache;

    private static WordsMatcher wordsMatcher;

    public synchronized static Map<WordMatcher.Type,WordMatcher> getWordMatchers() {
        initWordMatchers();
        return wordMatchersCache;
    }

    private static void initWordMatchers() {
        wordMatchersCache = wordMatchersCache != null ? wordMatchersCache : MatcherSettings.getSettings().getAvailableWordMatchers();
        if(wordMatchersCache == null || wordMatchersCache.isEmpty()) {
            System.out.println("[WARN] \tNo word matchers provided in settings file. Using all available matchers by default.");
            wordMatchersCache = Arrays.stream(WordMatcher.Type.values()).collect(Collectors.toMap(t -> t, WordMatcher.Type::getMatcher));
        }
    }

    public static WordMatcher getMatherOfType(WordMatcher.Type type) {
        return type.getMatcher();
    }

    public static WordsMatcher getWordsMatcher() {
        return wordsMatcher != null ? wordsMatcher : (wordsMatcher = new WordsMatcher(getWordMatchers()));
    }
}
