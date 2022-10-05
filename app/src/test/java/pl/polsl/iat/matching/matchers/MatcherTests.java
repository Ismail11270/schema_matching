package pl.polsl.iat.matching.matchers;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.matchers.word.WordsMatcher;
import pl.polsl.iat.matching.matchers.word.WordsMatcherFactory;
import pl.polsl.iat.matching.processing.FullStringProcessor;
import pl.polsl.iat.matching.processing.Words;
import pl.polsl.iat.matching.util.MatcherSettings;

public class MatcherTests {

    private static MatcherSettings settings;

    private static FullStringProcessor strPrc;
    private static WordsMatcher matcher;

    @BeforeAll
    public static void before() throws NlpMildException {
        NLPTools.init(false);
        settings = MatcherSettings.getSettings();
        strPrc = FullStringProcessor.get();
        matcher = WordsMatcherFactory.getWordsMatcher();
    }


    @Test
    public void testMatchers() {
        Words a = strPrc.process("usr_first_name");
        Words b = strPrc.process("complete_name");

        System.out.println(matcher.doMatch(a, b));
    }
}
