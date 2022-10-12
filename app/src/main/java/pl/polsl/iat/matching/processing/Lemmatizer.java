package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.dictionary.nlp.NLPLemmatizer;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.util.Logger;

class Lemmatizer implements TextProcessor<Words> {

    private final NLPLemmatizer nlpLemmatizer;

    Lemmatizer() {
        nlpLemmatizer = NLPTools.getLemmatizer();
    }

    @Override
    public Words process(Words words) {
//        System.out.println(Arrays.toString(words.posTags()));
        if(words.posTags().length == 0) {
            Logger.warn("Part of speech tagging is required prior to lemmatization.");
            return words;
        }
        String[] lemmas = nlpLemmatizer.doTheThing(words.wordsAsStrings(), words.posTags());
        words.update(lemmas);
        return words;
    }
}
