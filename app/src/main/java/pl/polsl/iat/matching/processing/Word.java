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
        if (o != null && o instanceof Word)
            return word.equals(((Word) o).word);
        return false;
    }

    @Override
    public int hashCode() {
        return Objects.hash(word);
    }
}
