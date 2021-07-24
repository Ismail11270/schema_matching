package pl.polsl.iat.matching.schema;

import pl.polsl.iat.matching.exception.RuntimeDatabaseException;

@FunctionalInterface
public interface UnsafePredicate<T> {
    boolean test(T t) throws RuntimeDatabaseException;
}
