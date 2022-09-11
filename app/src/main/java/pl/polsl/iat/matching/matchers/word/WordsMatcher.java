package pl.polsl.iat.matching.matchers.word;

import com.google.common.collect.Lists;
import pl.polsl.iat.matching.matchers.result.WordsMatchingResult;
import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.processing.Words;
import pl.polsl.iat.matching.util.Logger;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
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
        for (WordMatcher.Type typeMatcher : availableWordMatchers.entrySet().stream().map(e -> e.getKey()).collect(Collectors.toList())) {
            try {
                float matcherResult = matchWithMatcher(typeMatcher.getMatcher(), left, right);
                result.addResult(typeMatcher, matcherResult);
            } catch (Exception e) {
                Logger.warn("Error trying to match '%s' and '%s' using [%s] matcher.\tDetails:\t%s",left.toString(), right.toString(), typeMatcher.getName(), e.getClass().getName());
            }
        }
        return result;
    }

    private float matchWithMatcher(WordMatcher matcher, Words A, Words B) {
        Words smaller = A.size() < B.size() ? A : B;
        Words bigger = A.size() < B.size() ? B : A;
        int nSmaller = smaller.size(), nBigger = bigger.size();
        List<List<Integer>> cpResult = new ArrayList<>();
        for(int i = 0; i < nSmaller; i++) {
            List<Integer> temp = new ArrayList<>();
            for(int j = 0; j < nBigger; j++) {
                temp.add(matcher.doMatch(smaller.get(i), bigger.get(j)));
            }
            cpResult.add(temp);
        }
        List<List<Integer>> lists = Lists.cartesianProduct(cpResult);
        return lists.stream().map(l -> l.stream().reduce(0, Integer::sum) / nBigger).max(Integer::compareTo).get();
    }

}
