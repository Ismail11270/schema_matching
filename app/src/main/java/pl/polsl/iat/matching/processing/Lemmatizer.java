package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.dictionary.nlp.NLPLemmatizer;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;

class Lemmatizer implements TextProcessor<Words> {

    private final NLPLemmatizer nlpLemmatizer;

    Lemmatizer() {
        nlpLemmatizer = NLPTools.getLemmatizer();
    }

    @Override
    public Words process(Words words) {
        words.get().forEach(word -> word.updateWord(nlpLemmatizer::doTheThing));
        return words;
    }
}
