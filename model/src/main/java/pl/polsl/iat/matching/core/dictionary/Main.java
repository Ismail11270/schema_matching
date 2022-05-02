package pl.polsl.iat.matching.core.dictionary;

import pl.polsl.iat.matching.core.dictionary.impl.DictionaryFactory;
import pl.polsl.iat.matching.core.dictionary.exception.DictionaryException;

public class Main {
    public static void main(String[] args) throws DictionaryException {
        LexicalDictionary dict = new DictionaryFactory().getLexicalDictionary(null, false);

        dict.getNumberOfSynonyms("good");
    }
}
