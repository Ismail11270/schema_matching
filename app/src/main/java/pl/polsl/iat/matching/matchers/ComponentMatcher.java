package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.BaseCharacteristic;
import pl.polsl.iat.matching.core.model.schema.Component;
import pl.polsl.iat.matching.core.model.schema.ComponentType;
import pl.polsl.iat.matching.matchers.result.WordMatchingResult;
import pl.polsl.iat.matching.matchers.result.Results;
import pl.polsl.iat.matching.matchers.word.WordsMatcher;
import pl.polsl.iat.matching.matchers.word.WordsMatcherFactory;
import pl.polsl.iat.matching.processing.FullStringProcessor;
import pl.polsl.iat.matching.processing.Words;

import java.util.Map;

/**
 * ComponentMatcher only does name matching so far
 * TODO add metadata matching
 */
public abstract class ComponentMatcher implements Matcher<Component, Results> {

//    private static final ComponentMatcher instance = new ComponentMatcher();

    public static ComponentMatcher getInstance(ComponentType column) {
        if (column == ComponentType.SCHEMA) {
            return SchemaMatcher.getInstance();
        } else if (column == ComponentType.TABLE) {
            return TableMatcher.getInstance();
        } else if (column == ComponentType.COLUMN) {
            return ColumnMatcher.getInstance();
        }
        return null;
    }

    private final FullStringProcessor strProc = FullStringProcessor.get();
    private final WordsMatcher wordsMatcher = WordsMatcherFactory.getWordsMatcher();

    @Override
    public Results doMatch(Component left, Component  right) {
        //Combined results for all characteristics
        Results results = new Results();

        Map<?, ? extends BaseCharacteristic<?>> leftChars = left.getCharacteristics();
        Map<?, ? extends BaseCharacteristic<?>> rightChars = right.getCharacteristics();

        matchCharacteristics(leftChars, rightChars, results);
        return results;
    }

    protected void matchCharacteristics(Map<?, ? extends BaseCharacteristic<?>> leftChars, Map<?, ? extends BaseCharacteristic<?>> rightChars, Results results) {
        matchNames(leftChars, rightChars, results);
    }

    protected void matchNames(Map<?, ? extends BaseCharacteristic<?>> left, Map<?, ? extends BaseCharacteristic<?>> right, Results results) {
        Words leftWords = strProc.process(left.get(getNameCharacteristicsKey()).getValue());
        Words rightWords = strProc.process(right.get(getNameCharacteristicsKey()).getValue());
        WordMatchingResult nameMatchingResult = wordsMatcher.doMatch(leftWords, rightWords);
        results.add(nameMatchingResult);
    }

    protected abstract Object getNameCharacteristicsKey();
}
