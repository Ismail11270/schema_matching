package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.List;
import java.util.regex.Pattern;

public class FullStringProcessor implements TextProcessor<String> {
    private final static FullStringProcessor processor = new FullStringProcessor();

    private final static Pattern tokenizationPattern = Pattern.compile("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])|(_)");


    private final List<ProcessorType> allProcessors = MatcherSettings.getSettings().getAvailablePreProcessors();

    public static FullStringProcessor get() {
        return processor;
    }

    private FullStringProcessor() {
    }

    @Override
    public Words process(String input) {

        //Always tokenize and adjust to lowercase
        Words words = new Words(new Word(input), tokenizationPattern.split(input)).toLowerCase();
        //Apply all processors
        for (ProcessorType processor : allProcessors) {
            processor.getProcessor().get().process(words);
        }
        return words;
    }


}
