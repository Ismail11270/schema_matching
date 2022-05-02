package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Matchable;

public class Words implements Matchable {
    private String[] words;

    public Words(String... words) {
        this.words = words;
    }

    public String[] get() {
        return words;
    }

    public int size() {
        return words.length;
    }
}
