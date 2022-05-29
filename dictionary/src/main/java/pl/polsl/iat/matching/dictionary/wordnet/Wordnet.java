package pl.polsl.iat.matching.dictionary.wordnet;

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
    List<String> getRelatedWords(String word);

    List<String> getAntonyms(String word);

}
