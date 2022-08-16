package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.matchers.result.WordsMatchingResult;
import pl.polsl.iat.matching.processing.Word;

class ExactMatcher extends WordMatcher {

    private static ExactMatcher instance;

    private ExactMatcher() {

    }

    public static ExactMatcher getInstance() {
        if (instance == null) {
            instance = new ExactMatcher();
        }
        return instance;
    }

    @Override
    public WordsMatchingResult doMatch(Word left, Word right) {

        return null;
    }
}
