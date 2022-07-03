package pl.polsl.iat.matching.matchers.result;


public class WordMatchingResult extends AbstractResult {

    private final Float result;


    public WordMatchingResult(Float f){
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
