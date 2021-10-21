package pl.polsl.iat.matching.result;

import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.impl.SchemaExtractor;
import pl.polsl.iat.matching.util.MatcherSettings;
import pl.polsl.iat.matching.util.ParametersResolver;

public class GeneralTests {
    @Test
    public void loadSchemasAndGenerateResultXmlTest() {
        String[] sampleArgs = new String[]{"-s1", "-f", "..\\resources\\schema1.properties", "-s2", "-f", "..\\resources\\schema2.properties"};
        ParametersResolver parametersResolver = new ParametersResolver(sampleArgs);

        long start = System.currentTimeMillis();
        new ResultFactory()
                .createMatchingResult(parametersResolver.getConnectionProperties().stream()
                .map(p -> new SchemaExtractor(p).load(MatcherSettings.loaderMode))
                .toArray(Schema[]::new))
                .save("..\\result\\actual-result.xml");
        System.out.println("Time taken = " + (System.currentTimeMillis() - start));
    }
}
