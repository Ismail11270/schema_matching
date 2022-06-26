package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Component;
import pl.polsl.iat.matching.matchers.result.NameMatchingResult;
import pl.polsl.iat.matching.matchers.word.WordsMatcher;
import pl.polsl.iat.matching.matchers.word.WordsMatcherFactory;
import pl.polsl.iat.matching.processing.FullStringProcessor;
import pl.polsl.iat.matching.processing.Words;

/**
 * ComponentMatcher only does name matching so far
 * TODO add metadata matching
 */
public class ComponentMatcher implements Matcher<Component> {

    private static final ComponentMatcher instance = new ComponentMatcher();

    private ComponentMatcher() { }

    public static ComponentMatcher getInstance() {
        return instance;
    }

    private final FullStringProcessor strProc = FullStringProcessor.get();
    private final WordsMatcher wordsMatcher = WordsMatcherFactory.getWordsMatcher();

    @Override
    public NameMatchingResult doMatch(Component left, Component  right) {

        /*TODO
         * 1. Match type
         * 2. Match name
         * 3. Match remaining characteristics
         * */

        Words leftWords = strProc.process(left.getName());
        Words rightWords = strProc.process(right.getName());
        NameMatchingResult nameMatchingResult = wordsMatcher.doMatch(leftWords, rightWords);
        return nameMatchingResult;
//        PartialResult partialResult = wordsMatcher.doMatch(new Words(left.getName()), new Words(right.getName()));
//        return partialResult;
    }

    private void matchCharacteristics() {

    }
}
