package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.executor.result.PartialResult;
import pl.polsl.iat.matching.processing.Word;

public class ExactMatcher extends WordMatcher {

    @Override
    public PartialResult<Word> doMatch(Word left, Word right) {
        return null;
    }
}
