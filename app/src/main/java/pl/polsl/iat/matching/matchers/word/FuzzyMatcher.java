package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.processing.Word;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

class FuzzyMatcher extends WordMatcher {

    private static FuzzyMatcher instance;
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
        try {
            return (Integer) ((Method)getOption(Options.Fuzzy.METHOD)).invoke(null, left.toString(), right.toString());
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public Type getType() {
        return Type.FUZZY;
    }
}
