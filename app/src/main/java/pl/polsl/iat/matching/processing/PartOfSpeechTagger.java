package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.dictionary.nlp.POSTagger;
import pl.polsl.iat.matching.dictionary.nlp.POSTag;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

public class PartOfSpeechTagger implements TextProcessor<Words> {

    private POSTagger tagger;
    private final Object lock = new Object();

    public PartOfSpeechTagger() {
        tagger = NLPTools.getPOSTagger();
    }

    @Override
    public Words process(Words words) {
        if (tagger == null) return words;
        List<POSTag> tags = new ArrayList<>();
        synchronized (lock) {
             tags.addAll(tagger.tag(words.wordsAsStrings()));
        }
        IntStream.range(0, tags.size())
                .forEach(i -> words.get(i).setPos(tags.get(i)));
        return words;
    }
}
