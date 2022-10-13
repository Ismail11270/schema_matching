package pl.polsl.iat.matching.executor;

import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.core.model.result.ResultFactory;
import pl.polsl.iat.matching.core.model.schema.Schema;
import pl.polsl.iat.matching.core.model.schema.impl.SchemaExtractor;
import pl.polsl.iat.matching.core.util.ParametersResolver;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ExecutorTest {

    public void test() {

        Pattern ptrn = Pattern.compile("([a-zA-Z]+) (\\d+)");
        Matcher matcher = ptrn.matcher("June 24, August 9, Dec 12");

// This will reorder the string inline and print:
//   24 of June, 9 of August, 12 of Dec
// Remember that the first group is always the full matched text, so the
// month and day indices start from 1 instead of zero.
        String replacedString = matcher.replaceAll("$2 of $1");
        System.out.println(replacedString);
    }


    @Test
    public void test1() {

    }

    @Test
    public void loadSchemasAndGenerateResultXmlTest() {
        String[] sampleArgs = new String[]{"-s1", "-f", "..\\resources\\schema1.properties", "-s2", "-f", "..\\resources\\schema2.properties"};
        ParametersResolver parametersResolver = new ParametersResolver(sampleArgs);

        long start = System.currentTimeMillis();
        new ResultFactory()
                .createMatchingResult(parametersResolver.getConnectionProperties().stream()
                        .map(p -> new SchemaExtractor(p).load())
                        .toArray(Schema[]::new))
                .save("..\\result\\actual-result.xml");
        System.out.println("Time taken = " + (System.currentTimeMillis() - start));
    }

    private void addInt(Integer a, int i) {
        a+=i;
    }
}
