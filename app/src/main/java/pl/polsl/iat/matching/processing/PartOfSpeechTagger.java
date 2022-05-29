package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.nlp.POSTagger;
import pl.polsl.iat.matching.dictionary.nlp.POSTag;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.IntStream;

public class PartOfSpeechTagger implements TextProcessor<Words> {

    private POSTagger tagger;

    public PartOfSpeechTagger() {
        try {
            tagger = new POSTagger();
        } catch (NlpMildException e) {
            Logger.getLogger(PartOfSpeechTagger.class.getName())
                    .log(Level.WARNING,
                        "[PRE-PROCESSING] failed to initialize part of speech tagger. Details: %n%s",
                        e.getMessage());
        }
    }

    @Override
    public Words process(Words words) {
        if(tagger==null) return words;
        List<POSTag> tags = tagger.tag(words.wordsAsStrings());
        IntStream.range(0, tags.size())
                .forEach(i -> words.get(i).setPos(tags.get(i)));
        return words;
    }
}
