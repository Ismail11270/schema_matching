package pl.polsl.iat.matching.processing;

public interface TextProcessor<T> {
    Words process(T input);

    default boolean active() {
        return true;
    }
}
