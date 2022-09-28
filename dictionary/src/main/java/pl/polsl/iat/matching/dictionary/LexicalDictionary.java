package pl.polsl.iat.matching.dictionary;

import edu.mit.jwi.item.POS;

import java.util.List;

public interface LexicalDictionary {
    int getNumberOfSynonyms(String word, POS pos);

    List<String> getRelatedSynsetIds(String word, POS pos);

    int getNumberOfAntonyms(String word, POS pos);
    float compare(String first, String second, POS pos);

}
