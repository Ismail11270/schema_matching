package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Matchable;
import pl.polsl.iat.matching.matchers.result.NameMatchingResult;

public interface Matcher<T extends Matchable> {
    NameMatchingResult doMatch(T left, T right);
}
