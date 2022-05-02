package pl.polsl.iat.matching.matchers.processing.impl;

import me.xdrop.fuzzywuzzy.FuzzySearch;
import pl.polsl.iat.matching.core.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.core.dictionary.exception.DictionaryException;
import pl.polsl.iat.matching.core.dictionary.impl.DictionaryFactory;
import pl.polsl.iat.matching.matchers.processing.StringPair;

//TODO apply only matchers enabled in settings
public class StringMatcher {

    private StringProcessingUnit SPU = new StringProcessingUnit();
    private LexicalDictionary dictionary;

    public StringMatcher() throws DictionaryException {
        dictionary = new DictionaryFactory().getLexicalDictionary(null, false);
    }

    public int compare(StringPair pair) {
        if (exactMatch(pair)) {
            return MatchCoefficients.EXACT_MATCH;
        }
        if (exactMatch(SPU.process(pair.first()), SPU.process(pair.second()))) {
            return MatchCoefficients.EXACT_MATCH_PROCESSED;
        }
        int fuzzyMatch = fuzzyMatch(pair);
        int lexicalMatch = lexicalMatch(pair);

        return 0;
    }

    private boolean exactMatch(ProcessedString first, ProcessedString second) {
        if(first.getPieces().getPieces().length != second.getPieces().getPieces().length)
            return false;
        for (String piece : first.getPieces().getPieces()) {
            for(String piece_ : second.getPieces().getPieces()) {
                if(!piece.equals(piece_))
                    return false;
            }
        }
        return true;
    }

    private boolean exactMatch(StringPair pair) {
        return pair.first().equals(pair.second());
    }

    //TODO Test + provide
    private int fuzzyMatch(StringPair pair) {
        return FuzzySearch.ratio(pair.first(), pair.second());
    }

    private int lexicalMatch(StringPair pair) {
//        dictionary.compare()


        return 0;
    }

}