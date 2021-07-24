package pl.polsl.iat.matching.dictionary.impl;

import pl.polsl.iat.matching.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;
import pl.polsl.iat.matching.dictionary.result.MatchResult;

class LexicalDictionaryImpl implements LexicalDictionary {

    private Wordnet wordnet;

    LexicalDictionaryImpl(String dictionaryLocation, boolean loadToRam) throws DictionaryException {
        wordnet = new JwiWordnet(dictionaryLocation, loadToRam);
    }

    @Override
    public MatchResult compare(String first, String second) {
        wordnet.getSynonym(first).forEach(System.out::println);
        return new MatchResult();
    }
}
