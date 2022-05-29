package pl.polsl.iat.matching;

import pl.polsl.iat.matching.core.model.result.MatchingResult;
import pl.polsl.iat.matching.core.model.result.ResultFactory;
import pl.polsl.iat.matching.core.model.schema.Schema;
import pl.polsl.iat.matching.core.model.schema.impl.SchemaExtractor;
import pl.polsl.iat.matching.core.util.ParametersResolver;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.executor.impl.ExecutorFactory;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.Optional;

public class App {

    public static void main(String[] args) {
        //Init data and instruments
        ParametersResolver parametersResolver = new ParametersResolver(args);

        NLPTools.init(isLoadToRamSet());
        MatcherSettings settings = MatcherSettings.getSettings();

        //Schema loading start
        long startTime = System.currentTimeMillis();
        Schema[] schemas = parametersResolver.getConnectionProperties()
                .parallelStream()
                .map(p -> new SchemaExtractor(p).load(settings.getLoaderMode()))
                .toArray(Schema[]::new);
        MatchingResult matchingResult =
                new ResultFactory().createMatchingResult(schemas);
        long schemaLoadingTime = System.currentTimeMillis() - startTime;
        //Schema loading end

        //Matching start
        startTime = System.currentTimeMillis();

        ExecutorFactory.newSchemaMatchingExecutor(matchingResult, schemas).run();

        long matchingTime = System.currentTimeMillis() - startTime;
        //Matching done

        //Saving result
        startTime = System.currentTimeMillis();
        matchingResult.save("result\\actual-result.xml");
        long resultProcessingTime = System.currentTimeMillis() - startTime;
        //Saving result done

        System.out.println("Schema loading time - " + schemaLoadingTime);
        System.out.println("Matching time - " + matchingTime);
        System.out.println("Result processing time - " + resultProcessingTime);
        System.out.println("Total time - " + (schemaLoadingTime + matchingTime + resultProcessingTime) );

    }

    private static boolean isLoadToRamSet() {
        try {
            return Boolean.parseBoolean(Optional.ofNullable(System.getenv("WORDNET_TO_RAM")).orElse("false"));
        } catch(Exception e) {
            return false;
        }
    }
}
