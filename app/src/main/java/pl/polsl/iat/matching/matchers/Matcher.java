package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Matchable;

public interface Matcher<T extends Matchable, R> {
    R doMatch(T left, T right);
}
