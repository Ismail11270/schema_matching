package pl.polsl.iat.matching.dictionary;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.nlp.NLPLemmatizer;
import pl.polsl.iat.matching.dictionary.nlp.NLPStemmer;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.dictionary.nlp.POSTag;

public class NLPTest {


    @BeforeAll
    public static void before() throws NlpMildException {
        NLPTools.init(false);
    }

    @Test
    public void testStemmer() {
//        NLPStemmer stemmer = NLPTools.getStemmer();
//        var a = stemmer.doTheThing("tired");
//        System.out.println(a);
//
//        NLPLemmatizer lemmatizer = NLPTools.getLemmatizer();
//        var b = lemmatizer.doTheThing(new String[]{"tired"}, new POSTag[] {POSTag.JJ});
//        System.out.println(b[0]);
    }
}
