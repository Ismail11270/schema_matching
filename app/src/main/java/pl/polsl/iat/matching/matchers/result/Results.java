package pl.polsl.iat.matching.matchers.result;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Results {

    private List<AbstractResult> results = new ArrayList<>();

    public Results() {

    }

    public Results add(AbstractResult result) {
        results.add(result);
        return this;
    }

    private Random random = new Random();

    public Float calculateResult() {
        return random.nextFloat();
    }
}
