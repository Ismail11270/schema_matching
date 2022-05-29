package pl.polsl.iat.matching.dictionary.wordnet;

import pl.polsl.iat.matching.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;

class LexicalDictionaryImpl implements LexicalDictionary {

    private final Wordnet wordnet;

    LexicalDictionaryImpl(Wordnet wordnet) throws DictionaryException {
        this.wordnet = wordnet;
    }

    @Override
    public int getNumberOfSynonyms(String word) {
        return wordnet.getRelatedWords(word).size();
    }

    @Override
    public int getNumberOfAntonyms(String word) {
        return 0;
    }

    @Override
    public float compare(String first, String second) {
        wordnet.getRelatedWords(first).forEach(System.out::println);
//        return new MatchResult();
        return 0f;
    }
}
