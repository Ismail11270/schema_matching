package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.matchers.result.WordsMatchingResult;
import pl.polsl.iat.matching.processing.Word;

class SemanticMather extends WordMatcher {

    private static SemanticMather instance;

    private SemanticMather() {

    }

    public static SemanticMather getInstance() {
        if (instance == null) {
            instance = new SemanticMather();
        }
        return instance;
    }

    @Override
    public Integer doMatch(Word left, Word right) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
