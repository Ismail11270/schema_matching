package pl.polsl.iat.matching.dictionary.impl;

import pl.polsl.iat.matching.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;

public class DictionaryFactory {
    public LexicalDictionary getLexicalDictionary(String dictionaryLocation, boolean loadToRam) throws DictionaryException {
        return new LexicalDictionaryImpl(dictionaryLocation, loadToRam);
    }
}
