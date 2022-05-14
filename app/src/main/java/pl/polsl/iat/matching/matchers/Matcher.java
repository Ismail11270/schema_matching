package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Matchable;
import pl.polsl.iat.matching.matchers.result.PartialResult;

public interface Matcher<T extends Matchable> {
    PartialResult doMatch(T left, T right);
}
