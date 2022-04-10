package pl.polsl.iat.matching.dictionary;

import pl.polsl.iat.matching.dictionary.exception.DictionaryException;
import pl.polsl.iat.matching.dictionary.impl.DictionaryFactory;

public class Main {
    public static void main(String[] args) throws DictionaryException {
        LexicalDictionary dict = new DictionaryFactory().getLexicalDictionary(null, false);

        dict.getNumberOfSynonyms("good");
    }
}
