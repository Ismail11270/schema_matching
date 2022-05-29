package pl.polsl.iat.matching.dictionary;

public interface LexicalDictionary {
    int getNumberOfSynonyms(String word);
    int getNumberOfAntonyms(String word);
    float compare(String first, String second);

}
