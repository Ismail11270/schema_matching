package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.core.model.schema.Matchable;

import java.util.Arrays;
import java.util.List;
import java.util.function.IntFunction;
import java.util.function.Predicate;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class Words implements Matchable {
    private List<Word> words;

    public Words(String... words) {
        this.words = Arrays.stream(words).filter(w -> !w.isBlank()).map(String::toLowerCase).map(Word::new).collect(Collectors.toList());
    }

    public List<Word> get() {
        return words;
    }


    public int size() {
        return words.size();
    }

    @Override
    public String toString() {
        return words.stream().map(Word::toString).collect(Collectors.joining(", "));
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

}
