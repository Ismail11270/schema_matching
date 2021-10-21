package pl.polsl.iat.matching.processing.impl;

import me.xdrop.fuzzywuzzy.FuzzySearch;
import pl.polsl.iat.matching.processing.StringPair;

//TODO apply only matchers enabled in settings
public class StringMatcher {

    //TODO INIT PROCESSOR
    private StringProcessingUnit SPU = new StringProcessingUnit();


    public int compare(StringPair pair) {
        if (exactMatch(pair)) {
            return 100;
        }
        if (exactMatch(SPU.process(pair.first()), SPU.process(pair.second()))) {
            return 90;
        }
        int fuzzyMatch = fuzzyMatch(pair);

        return 0;
    }

    private boolean exactMatch(ProcessedString process, ProcessedString process1) {
        return true;
    }

    private boolean exactMatch(StringPair pair) {
        return pair.first().equals(pair.second());
    }

    //TODO Test + provide
    private int fuzzyMatch(StringPair pair) {
        return FuzzySearch.ratio(pair.first(), pair.second());
    }

    private int lexicalMatch() {



        return 0;
    }

}