package pl.polsl.iat.matching.matchers.result;

public abstract class AbstractResult<T> {

    public abstract T getResult();
    public abstract float getWeight();
}
