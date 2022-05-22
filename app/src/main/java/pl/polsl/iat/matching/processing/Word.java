package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.core.model.schema.Matchable;

import java.util.regex.Pattern;

public class Word implements Matchable {

    private String word;

    public Word(String word) {
        this.word = word;
    }

    @Override
    public String toString() {
        return word;
    }

    public Word toLowerCase() {
        this.word = word.toLowerCase();
        return this;
    }

    public Word remove(Pattern pattern) {
        this.word = pattern.matcher(this.word).replaceAll("");
        return this;
    }
}
