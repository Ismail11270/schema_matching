package pl.polsl.iat.matching.dictionary;

import edu.mit.jwi.item.POS;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;

import java.util.Collection;
import java.util.List;

public class DictionaryTest {

    @BeforeAll
    public static void before() throws NlpMildException {
        NLPTools.init(false);
    }


    @Test
    public void test() {
        LexicalDictionary dictionary = NLPTools.getLexicalDictionary();
//        int first_name = dictionary.getNumberOfSynonyms("user", POS.NOUN);

        long timeStart = System.currentTimeMillis();
        Collection<String> user = dictionary.getRelatedSynsetIds("applicant", POS.NOUN);
        Collection<String> person = dictionary.getRelatedSynsetIds("candidate", POS.NOUN);
        var bigger = user.size() > person.size() ? user : person;
        var smaller = user.size() < person.size() ? user : person;

        int a = bigger.size();
        int b = smaller.size();
//        System.out.println("bigger " + a);
//        System.out.println("smaller " + b);
        bigger.removeAll(smaller);
//        System.out.println(bigger.size());
        int c = bigger.size();

        float removed = a - c;
        float result = removed/b;
//        System.out.println(removed);
        System.out.println(result);

        System.out.println("Execution time = " + (System.currentTimeMillis() - timeStart));
//        System.out.println(user.size());
//        System.out.println(first_name);
    }
}
