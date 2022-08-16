package pl.polsl.iat.matching.matchers.result;


import pl.polsl.iat.matching.matchers.word.WordMatcher;

import java.util.HashMap;
import java.util.Map;

public class WordsMatchingResult extends AbstractResult {

    private Float combinedResult;

    private Map<WordMatcher.Type, Float> resultsMap = new HashMap<>();

    public WordsMatchingResult(){

    }

    public Float getTotalResult() {
        //TODO Combine results
        if(combinedResult == null) {
            combinedResult = 0f;
        }
        return combinedResult;
    }

    public WordsMatchingResult addResult(WordMatcher.Type matcherType, Float result) {
        this.resultsMap.put(matcherType, result);
        return this;
    }

    @Override
    public String toString() {
        return "NameMatchingResult{" +
                "result=" + combinedResult +
                '}';
    }

    @Override
    public float getWeight() {
        return 0;
    }
}
