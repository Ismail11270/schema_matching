package pl.polsl.iat.matching.matchers.result;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

public class Results {

    private List<AbstractResult> results = new ArrayList<>();
    private Integer calculatedResult = null;

    public Results() {

    }

    public Results add(AbstractResult result) {
        results.add(result);
        return this;
    }

    public int calculateResult() {
        if(calculatedResult == null && results.isEmpty()) {
            calculatedResult = 0;
        } else if(calculatedResult == null){
            calculatedResult = results.stream().mapToInt(AbstractResult::getResult).sum() / results.size();
        }
        return calculatedResult;
    }
}
