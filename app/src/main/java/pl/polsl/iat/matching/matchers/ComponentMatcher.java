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

import java.util.List;
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

        /*TODO
         * 1. Match type
         * 2. Match name
         * 3. Match remaining characteristics
         * */

        Words leftWords = strProc.process(left.getName());
        Words rightWords = strProc.process(right.getName());
        WordMatchingResult nameMatchingResult = wordsMatcher.doMatch(leftWords, rightWords);

        Map<?, ? extends BaseCharacteristic<?>> leftChars = left.getCharacteristics();
        Map<?, ? extends BaseCharacteristic<?>> rightChars = right.getCharacteristics();

        return new Results().add(nameMatchingResult);
//        PartialResult partialResult = wordsMatcher.doMatch(new Words(left.getName()), new Words(right.getName()));
//        return partialResult;
    }

    private void matchCharacteristics() {

    }
}
