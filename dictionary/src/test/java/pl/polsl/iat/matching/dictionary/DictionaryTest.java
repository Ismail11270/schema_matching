package pl.polsl.iat.matching.dictionary;

import edu.mit.jwi.item.POS;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;

public class DictionaryTest {

    @BeforeAll
    public static void before() throws NlpMildException {
        NLPTools.init(false);
    }


    @Test
    public void test() {
       LexicalDictionary dictionary = NLPTools.getLexicalDictionary();
        int first_name = dictionary.getNumberOfSynonyms("code", POS.NOUN);
        System.out.println(first_name);
    }
}
