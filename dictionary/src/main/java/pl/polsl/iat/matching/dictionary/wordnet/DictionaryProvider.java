package pl.polsl.iat.matching.dictionary.wordnet;

import pl.polsl.iat.matching.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;

import java.util.Optional;

public class DictionaryProvider {
    private static LexicalDictionary dictionary;
    private static Wordnet wordnet;

    public static LexicalDictionary getLexicalDictionary(String dictionaryLocation, boolean loadToRam) throws DictionaryException {
        return Optional.ofNullable(dictionary).orElseGet(DictionaryProvider::initDictionary);
    }

    private static LexicalDictionary initDictionary() {
        dictionary = new LexicalDictionaryImpl(wordnet);
        return dictionary;
    }

    public static Wordnet getWordnet() {
        return wordnet;
    }
}
