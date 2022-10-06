package pl.polsl.iat.matching.dictionary.nlp;

import edu.mit.jwi.item.POS;
import edu.mit.jwi.morph.WordnetStemmer;

import java.util.Collection;
import java.util.List;


/**
 * Interface defining basic functionality provided by all wordnet implementations
 */
public interface Wordnet {

    /**
     *
     * @param word - word to find synonyms for
     * @return list of synonyms
     */
    List<String> getRelatedWords(String word, POS pos);

    Collection<String> getRleatedSynsets(String word, POS pos);

    List<String> getAntonyms(String word, POS pos);

    WordnetStemmer getStemmer();

}
