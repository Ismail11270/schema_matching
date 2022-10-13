package pl.polsl.iat.matching;

import pl.polsl.iat.matching.core.model.result.MatchingResult;
import pl.polsl.iat.matching.core.model.result.ResultFactory;
import pl.polsl.iat.matching.core.model.schema.Schema;
import pl.polsl.iat.matching.core.model.schema.impl.SchemaExtractor;
import pl.polsl.iat.matching.core.util.ParametersResolver;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.executor.impl.ExecutorFactory;
import pl.polsl.iat.matching.executor.impl.SchemaMatcherRunner;
import pl.polsl.iat.matching.processing.ProcessorType;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.Arrays;
import java.util.Optional;
import java.util.stream.Collectors;

public class App {

    public static void main(String[] args) throws NlpMildException {
        //Init data and instruments
        ParametersResolver parametersResolver = new ParametersResolver(args);


        // Settings ended up being dependent on NLPTools so dictionary settings can't be included in the settings therefore they are just taken from the environment
        NLPTools.init(isLoadToRamSet());
        MatcherSettings settings = MatcherSettings.getSettings();

        //Schema loading start
        long startTime = System.currentTimeMillis();
        Schema[] schemas = parametersResolver.getConnectionProperties()
                .stream()
                .map(p -> new SchemaExtractor(p).load())
                .toArray(Schema[]::new);
        MatchingResult matchingResult =
                new ResultFactory().createMatchingResult(schemas);
        long schemaLoadingTime = System.currentTimeMillis() - startTime;
        //Schema loading end
        System.out.println("==========================================================================================");
        System.out.println("Preprocessing applied - " + settings.getAvailablePreProcessors().stream().map(ProcessorType::name).reduce((a, b) -> a + ", " + b).get());
        System.out.println("==========================================================================================");
        System.out.println("Word matchers applied - " + settings.getAvailableWordMatchers().keySet());
        System.out.println("==========================================================================================");
        //Matching start
        startTime = System.currentTimeMillis();

        ExecutorFactory.newSchemaMatchingExecutor(matchingResult, schemas).forEach(SchemaMatcherRunner::run);

        long matchingTime = System.currentTimeMillis() - startTime;
        //Matching done

        //Saving result
        startTime = System.currentTimeMillis();
//        matchingResult.evaluate();
        matchingResult.save(getResultFile());
        long resultProcessingTime = System.currentTimeMillis() - startTime;
        //Saving result done

        System.out.println("Schema loading time - " + schemaLoadingTime);
        System.out.println("Matching time - " + matchingTime);
        System.out.println("Result processing time - " + resultProcessingTime);
        System.out.println("Total time - " + (schemaLoadingTime + matchingTime + resultProcessingTime) );

    }

    private static boolean isLoadToRamSet() {
        try {
            return Boolean.parseBoolean(Optional.ofNullable(System.getenv("WORDNET_TO_RAM")).orElse("true"));
        } catch(Exception e) {
            return false;
        }
    }

    private static String getResultFile() {
        try {
            String result_dir = Optional.ofNullable(System.getenv("RESULT_DIR")).orElse("result");
            return result_dir + "\\results.xml";
        } catch(Exception e) {
            e.printStackTrace();
            return "result\\actual-result.xml";
        }
    }
}

