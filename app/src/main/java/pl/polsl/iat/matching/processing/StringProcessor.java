package pl.polsl.iat.matching.processing;

public interface StringProcessor<T> {
    Words process(T input);
}
