package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Matchable;
import pl.polsl.iat.matching.executor.result.PartialResult;

public interface Matcher<T extends Matchable> {
    PartialResult<T> doMatch(T left, T right);
}
