package pl.polsl.iat.matching.matchers.word;

import me.xdrop.fuzzywuzzy.FuzzySearch;
import pl.polsl.iat.matching.matchers.result.WordsMatchingResult;
import pl.polsl.iat.matching.processing.Word;

class FuzzyMatcher extends WordMatcher {

    private static FuzzyMatcher instance;

    private FuzzyMatcher() {

    }

    public static FuzzyMatcher getInstance() {
        if (instance == null) {
            instance = new FuzzyMatcher();
        }
        return instance;
    }

    @Override
    public Integer doMatch(Word left, Word right) {
        return FuzzySearch.tokenSetRatio(left.toString(), right.toString());
    }
}
