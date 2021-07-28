package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.matchers.result.MatchingResult;

public interface ComponentMatcher<T> {
    MatchingResult doMatch(T A, T B);
}
