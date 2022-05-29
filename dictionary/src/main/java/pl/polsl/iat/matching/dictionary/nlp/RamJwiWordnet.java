package pl.polsl.iat.matching.dictionary.nlp;

import edu.mit.jwi.morph.WordnetStemmer;

import java.util.List;

/**
 * TODO Implement RAM loading
 */
class RamJwiWordnet implements Wordnet {

    RamJwiWordnet(String dictionaryLocation) {

    }

    @Override
    public List<String> getRelatedWords(String word) {
        return null;
    }

    @Override
    public List<String> getAntonyms(String word) {
        return null;
    }

    @Override
    public WordnetStemmer getStemmer() {
        return null;
    }
}
