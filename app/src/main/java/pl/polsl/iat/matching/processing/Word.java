package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.core.model.schema.Matchable;
import pl.polsl.iat.matching.dictionary.nlp.POSTag;

import java.util.Objects;
import java.util.function.Function;
import java.util.regex.Pattern;

public class Word implements Matchable {

    private String word;

    private POSTag pos;

    public Word(String word) {
        this.word = word;
    }

    public Word(String word, POSTag pos) {
        this.word = word;
        this.pos = pos;
    }

    @Override
    public String toString() {
        return word;
    }

    public Word toLowerCase() {
        this.word = word.toLowerCase();
        return this;
    }

    public void remove(Pattern pattern) {
        this.word = pattern.matcher(this.word).replaceAll("");
    }

    public void setPos(POSTag pos) {
        this.pos = pos;
    }

    public POSTag getPos() {
        return pos;
    }

    public void updateWord(String newWord) {
        this.word = newWord;
    }

    public void updateWord(Function<String,String> newWordFunction) {
        word = newWordFunction.apply(word);
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof Word)
            return word.equals(((Word) o).word);
        return false;
    }

    @Override
    public int hashCode() {
        return Objects.hash(word);
    }
}
