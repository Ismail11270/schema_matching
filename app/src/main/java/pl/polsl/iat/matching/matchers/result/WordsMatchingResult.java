package pl.polsl.iat.matching.matchers.result;


import pl.polsl.iat.matching.matchers.word.WordMatcher;

import java.util.HashMap;
import java.util.Map;

public class WordsMatchingResult extends AbstractResult {

    private Integer combinedResult;

    private Map<WordMatcher.Type, Integer> resultsMap = new HashMap<>();

    public WordsMatchingResult(){

    }

    public int getTotalResult() {
        //TODO Combine results
        if(combinedResult == null) {
            combinedResult = resultsMap.values().stream().reduce(0, (a, b) -> a + b / 2);
        }
        return combinedResult;
    }

    public WordsMatchingResult addResult(WordMatcher.Type matcherType, int result) {
        this.resultsMap.put(matcherType, result);
        return this;
    }

    @Override
    public String toString() {
        return "NameMatchingResult{" +
                "result=" + getTotalResult() +
                '}';
    }

    @Override
    public float getWeight() {
        return 0;
    }
}
