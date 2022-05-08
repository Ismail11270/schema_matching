package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Component;
import pl.polsl.iat.matching.matchers.result.PartialResult;
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
    public PartialResult doMatch(Component left, Component  right) {
        Words leftWords = strProc.process(left.getName());
        Words rightWords = strProc.process(right.getName());

        return wordsMatcher.doMatch(leftWords, rightWords);
    }
}
