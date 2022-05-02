package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.core.model.schema.Matchable;

public class Word implements Matchable {

    private final String word;

    public Word(String word) {
        this.word = word;
    }
}
