package pl.polsl.iat.matching.matchers.result;

import java.util.ArrayList;
import java.util.List;

public class Results {

    private List<AbstractResult> results = new ArrayList<>();

    public Results() {

    }

    public Results add(AbstractResult result) {
        results.add(result);
        return this;
    }

    public Float calculateResult() {
        return 0f;
    }
}
