package pl.polsl.iat.matching.executor.impl.matchers;

import me.xdrop.fuzzywuzzy.FuzzySearch;

//TODO apply only matchers enabled in settings
public class StringMatcher {

    //TODO INIT PROCESSOR
    private StringProcessor processor;


    public int compare(StringPair pair) {
        if (exactMatch(pair)) {
            return 100;
        }
        if (exactMatch(processor.process(pair))) {
            return 90;
        }
        int fuzzyMatch = fuzzyMatch(pair);

        return 0;
    }

    private boolean exactMatch(StringPair pair) {
        return pair.first().equals(pair.second());
    }

    //TODO Test + provide
    private int fuzzyMatch(StringPair pair) {
        return FuzzySearch.ratio(pair.first(), pair.second());
    }

}