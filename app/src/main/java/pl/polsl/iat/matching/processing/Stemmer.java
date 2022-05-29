package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.dictionary.nlp.NLPStemmer;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;

class Stemmer implements TextProcessor<Words> {

    private final NLPStemmer nlpStemmer;

    Stemmer() {
        nlpStemmer = NLPTools.getStemmer();
    }

    @Override
    public Words process(Words words) {
        words.get().forEach(word -> word.updateWord(nlpStemmer::doTheThing));
        return words;
    }
}
