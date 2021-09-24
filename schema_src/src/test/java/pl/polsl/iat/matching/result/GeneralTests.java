package pl.polsl.iat.matching.result;

import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.matchers.MatcherType;
import pl.polsl.iat.matching.matchers.SchemaMatcher;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.impl.SchemaExtractor;
import pl.polsl.iat.matching.sql.ConnectionProperties;
import pl.polsl.iat.matching.util.MatcherSettings;
import pl.polsl.iat.matching.util.ParametersResolver;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Random;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

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
