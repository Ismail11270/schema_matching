package pl.polsl.iat.matching.dictionary;

import pl.polsl.iat.matching.dictionary.result.MatchResult;

public interface LexicalDictionary {
    MatchResult compare(String first, String second);

}
