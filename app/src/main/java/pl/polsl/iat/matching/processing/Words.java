package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.core.model.schema.Matchable;
import pl.polsl.iat.matching.dictionary.nlp.POSTag;
import pl.polsl.iat.matching.util.Logger;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.function.Predicate;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Words implements Matchable {
    private List<Word> words;

    public Words(String... words) {
        this.words = Arrays.stream(words).filter(w -> !w.isBlank()).map(String::toLowerCase).map(Word::new).collect(Collectors.toList());
    }

    public List<Word> get() {
        return words;
    }

    public Word get(int i) {
        return words.get(i);
    }

    public int size() {
        return words.size();
    }

    public void remove(int index) {
        words.remove(index);
    }

    @Override
    public String toString() {
        return words.stream().map(Word::toString).collect(Collectors.joining(", "));
    }

    public String[] wordsAsStrings() {
        return words.stream().map(Word::toString).toArray(String[]::new);
    }

    public POSTag[] posTags() {

        return words.stream().map(Word::getPos).filter(Objects::nonNull).toArray(POSTag[]::new);
    }

    public Words toLowerCase() {
        for(Word word: words) {
            word = word.toLowerCase();
        }
        return this;
    }

    public Words remove(Pattern pattern) {
        words.stream().forEach(x -> x.remove(pattern));
        return this;
    }

    public Words filter(Predicate<Word> filter) {
        words = words.stream().filter(filter).collect(Collectors.toList());
        return this;
    }

    public void update(String[] words) {
        if(words.length != this.words.size()) {
            Logger.warn("Words were not update from '%s' to '%s'", this.toString(), Arrays.toString(words));
            return;
        }
        IntStream.range(0, words.length).forEach(i -> this.words.get(i).updateWord(words[i]));
    }
}
