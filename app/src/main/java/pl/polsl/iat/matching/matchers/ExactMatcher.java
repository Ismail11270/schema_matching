package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.executor.result.PartialResult;

public class ExactMatcher extends WordMatcher {

    @Override
    public PartialResult<Word> doMatch(Word left, Word right) {
        return null;
    }
}
