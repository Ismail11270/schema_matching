package pl.polsl.iat.matching.processing;

public interface TextProcessor<T> {
    Words process(T input);
}
