package pl.polsl.iat.matching.core.dictionary.impl;

import pl.polsl.iat.matching.core.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.core.dictionary.exception.DictionaryException;

class LexicalDictionaryImpl implements LexicalDictionary {

    private Wordnet wordnet;

    LexicalDictionaryImpl(String dictionaryLocation, boolean loadToRam) throws DictionaryException {
        wordnet = new JwiWordnet(dictionaryLocation, loadToRam);
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
