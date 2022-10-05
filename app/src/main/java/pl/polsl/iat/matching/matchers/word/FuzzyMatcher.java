package pl.polsl.iat.matching.matchers.word;

import me.xdrop.fuzzywuzzy.FuzzySearch;
import pl.polsl.iat.matching.matchers.result.WordsMatchingResult;
import pl.polsl.iat.matching.processing.Word;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

class FuzzyMatcher extends WordMatcher {

    private static FuzzyMatcher instance;
    private static Method method;
    private FuzzyMatcher() {
    }

    public static FuzzyMatcher getInstance() {
        if (instance == null) {
            instance = new FuzzyMatcher();
        }
        return instance;
    }

    @Override
    public Integer doMatch(Word left, Word right) {
//        System.out.println("Ratio                 " + FuzzySearch.ratio(left.toString(), right.toString()));
//        System.out.println("Partial ratio         " + FuzzySearch.partialRatio(left.toString(), right.toString()));
//        System.out.println("Token set ratio       " + FuzzySearch.tokenSetRatio(left.toString(), right.toString()));
//        System.out.println("Token set part ratio  " + FuzzySearch.tokenSetPartialRatio(left.toString(), right.toString()));
//        System.out.println("Token sort ratio      " + FuzzySearch.tokenSortRatio(left.toString(), right.toString()));
//        System.out.println("Token sort part ratio " + FuzzySearch.tokenSortPartialRatio(left.toString(), right.toString()));
//        System.out.println("Weighte ratio         " + FuzzySearch.weightedRatio(left.toString(), right.toString()));
        try {
            return (Integer) ((Method)getOption(Options.Fuzzy.METHOD)).invoke(null, left.toString(), right.toString());
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
            return 0;
        }
    }
}
