package pl.polsl.iat.matching.matchers.result;


public class NameMatchingResult extends AbstractResult {

    private final Float result;


    public NameMatchingResult(Float f){
        result = f;
    }

    public Float getResult() {
        return result;
    }

    @Override
    public String toString() {
        return "NameMatchingResult{" +
                "result=" + result +
                '}';
    }

    @Override
    public float getWeight() {
        return 0;
    }
}
