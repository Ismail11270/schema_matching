package pl.polsl.iat.matching.matchers.result;


import pl.polsl.iat.matching.matchers.word.WordMatcher;


public class WordsMatchingResult extends AbstractResult {

    private int result;
    private WordMatcher.Type type;

    public WordsMatchingResult(){

    }

    @Override
    public int getResult() {
        return result;
    }

    public WordMatcher.Type getType() {
        return type;
    }

    public void setResult(int result, WordMatcher.Type type) {
        this.result = result;
        this.type = type;
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
