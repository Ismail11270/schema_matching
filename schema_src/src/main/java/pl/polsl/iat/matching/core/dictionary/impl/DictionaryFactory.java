package pl.polsl.iat.matching.core.dictionary.impl;

import pl.polsl.iat.matching.core.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.core.dictionary.exception.DictionaryException;

public class DictionaryFactory {
    public LexicalDictionary getLexicalDictionary(String dictionaryLocation, boolean loadToRam) throws DictionaryException {
        return new LexicalDictionaryImpl(dictionaryLocation, loadToRam);
    }
}
