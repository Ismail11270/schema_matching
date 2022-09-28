package pl.polsl.iat.matching.dictionary.nlp;

import edu.mit.jwi.item.POS;
import edu.mit.jwi.morph.WordnetStemmer;

import java.util.List;

/**
 * TODO Implement RAM loading
 */
class RamJwiWordnet implements Wordnet {

    RamJwiWordnet(String dictionaryLocation) {

    }
    
    @Override
    public List<String> getRelatedWords(String word, POS pos) {
        return null;
    }

    @Override
    public List<String> getAntonyms(String word, POS pos) {
        return null;
    }

    @Override
    public WordnetStemmer getStemmer() {
        return null;
    }
}
