package pl.polsl.iat.matching.dictionary.nlp;

import edu.mit.jwi.item.POS;
import pl.polsl.iat.matching.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;

import java.util.Collection;
import java.util.List;

class LexicalDictionaryImpl implements LexicalDictionary {

    private final Wordnet wordnet;

    LexicalDictionaryImpl(Wordnet wordnet) throws DictionaryException {
        this.wordnet = wordnet;
    }

    @Override
    public int getNumberOfSynonyms(String word, POS pos) {
        return wordnet.getRelatedWords(word, pos).size();
    }

    @Override
    public Collection<String> getRelatedSynsetIds(String word, POS pos) {
        return wordnet.getRleatedSynsets(word, pos);
    }

    @Override
    public int getNumberOfAntonyms(String word, POS pos) {
        return 0;
    }

    @Override
    public float compare(String first, String second, POS pos) {
        wordnet.getRelatedWords(first, pos).forEach(System.out::println);
//        return new MatchResult();
        return 0f;
    }
}
