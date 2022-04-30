package pl.polsl.iat.matching.result;

import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.core.result.ResultFactory;
import pl.polsl.iat.matching.core.schema.model.Schema;
import pl.polsl.iat.matching.core.schema.model.impl.SchemaExtractor;
import pl.polsl.iat.matching.core.util.MatcherSettings;
import pl.polsl.iat.matching.core.util.ParametersResolver;

@SuppressWarnings("ALL")
public class GeneralTests {
    @Test
    public void loadSchemasAndGenerateResultXmlTest() {
        String[] sampleArgs = new String[]{"-s1", "-f", "..\\resources\\schema1.properties", "-s2", "-f", "..\\resources\\schema2.properties"};
        ParametersResolver parametersResolver = new ParametersResolver(sampleArgs);

        long start = System.currentTimeMillis();
        new ResultFactory()
                .createMatchingResult(parametersResolver.getConnectionProperties().stream()
                .map(p -> new SchemaExtractor(p).load(MatcherSettings.getSettings().getLoaderMode()))
                .toArray(Schema[]::new))
                .save("..\\result\\actual-result.xml");
        System.out.println("Time taken = " + (System.currentTimeMillis() - start));
    }
}
