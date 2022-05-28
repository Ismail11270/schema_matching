package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

public class FullStringProcessor implements TextProcessor<String> {
    private final static FullStringProcessor processor = new FullStringProcessor();

    private final static Pattern tokenizationPattern = Pattern.compile("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])|(_)");
    private final static Pattern nonAlphabeticPattern = Pattern.compile("\\W|\\d");

    private final List<ProcessorType> allProcessors = MatcherSettings.getSettings().getAvailablePreProcessors();

    public static FullStringProcessor get() {
        return processor;
    }

    private FullStringProcessor() {
    }

    //TODO
    @Override
    public Words process(String input) {

        /*TODO
        *  1. tokenization DONE
        *  2. to lowercase DONE
        *  3. remove symbols and numbers DONE
        *  4. remove stop words
        *  5. lemmatization?
        *  6. stemming
        *  7. prefix detection
        * */

//        Pattern tokenizationPattern = Pattern.compile("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])|(_)");
        Words words = new Words(tokenizationPattern.split(input));
        words.toLowerCase();
        words.remove(nonAlphabeticPattern);


        return words;
    }


}
