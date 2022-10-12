package pl.polsl.iat.matching.matchers.word;

import com.google.common.collect.Lists;
import pl.polsl.iat.matching.processing.Words;
import pl.polsl.iat.matching.util.Logger;
import pl.polsl.iat.matching.matchers.result.WordsMatchingResult;
import pl.polsl.iat.matching.matchers.Matcher;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class WordsMatcher implements Matcher<Words, WordsMatchingResult> {

    private final Map<WordMatcher.Type, WordMatcher> wordMatchers;

    WordsMatcher(Map<WordMatcher.Type, WordMatcher> matchers) {
        this.wordMatchers=matchers;
    }

    @Override
    public WordsMatchingResult doMatch(Words left, Words right) {
        WordsMatchingResult result = new WordsMatchingResult();
        for (WordMatcher.Type typeMatcher : wordMatchers.keySet().stream().toList()) {
            try {
                int matcherResult = matchWithMatcher(typeMatcher.getMatcher(), left, right);
                if(matcherResult <= result.getResult())
                    continue;
                result.setResult(matcherResult, typeMatcher);
                if(matcherResult == 100) {
                    break;
                }
            } catch (Exception e) {
                Logger.warn("Error trying to match '%s' and '%s' using [%s] matcher.\tDetails:\t%s",left.toString(), right.toString(), typeMatcher.getName(), e.getClass().getName());
                e.printStackTrace();
            }
        }
        return result;
    }

    private int matchWithMatcher(WordMatcher matcher, Words A, Words B) {
        try {
            if(matcher.getType() == WordMatcher.Type.EXACT) {
                int rawMatch = matcher.doMatch(A.getRawWord(), B.getRawWord());
                if (rawMatch == 100) {
                    return 100;
                }
            }
        } catch (Exception e) {
            Logger.warn("Error matching raw words");
        }
        Words smaller = A.size() < B.size() ? A : B;
        Words bigger = A.size() < B.size() ? B : A;
        int nSmaller = smaller.size(), nBigger = bigger.size();
        if(nSmaller == 0 || nBigger == 0) {
            return matcher.doMatch(smaller.getRawWord(), bigger.getRawWord());
        }
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
