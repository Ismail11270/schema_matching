package pl.polsl.iat.matching.processing;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringProcessingTest {

    private final TextProcessor<String> mainProc = FullStringProcessor.get();

    @BeforeAll
    public static void before() {
        NLPTools.init(false);
    }

    @Test
    public void testFullStringProcessing() {
        Map<String, Words> processingMap = Map.of(
                "Sexy", new Words("first", "name"),
                "testing_result", new Words(""),
                "test_outcome", new Words(""),
                "trial_result", new Words(""),
                "trailOutcome", new Words(""),
                "1test_result", new Words(""),
                "qq_test__result", new Words("")
        );

        processingMap.keySet().stream().map(mainProc::process).forEach(System.out::println);

    }


    @Test
    public void testRegex() {
        Pattern tokenizationPattern = Pattern.compile("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])|(_)");
        Pattern nonAlphabeticPattern = Pattern.compile("\\W|\\d");
        String text = "kurwa12$#";
        Matcher matcher = nonAlphabeticPattern.matcher(text);
        String s = matcher.replaceAll("");
        System.out.println(s);
        Matcher first_name = tokenizationPattern.matcher("first_name");
        while(first_name.find()) {
            System.out.println(first_name.group());
        }
    }


    @Test
    public void test1() {

    }
}
