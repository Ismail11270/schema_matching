package pl.polsl.iat.matching.executor;

import pl.polsl.iat.matching.executor.impl.ExecutorFactory;
import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.result.ResultFactory;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.impl.SchemaExtractor;
import pl.polsl.iat.matching.util.MatcherSettings;
import pl.polsl.iat.matching.util.ParametersResolver;

import java.util.List;
import java.util.stream.Collectors;

public class Main {

    public static void main(String[] args) {
        ParametersResolver parametersResolver = new ParametersResolver(args);
        List<Schema> schemas = parametersResolver.getConnectionProperties().stream()
                .map(p -> new SchemaExtractor(p).load(MatcherSettings.loaderMode))
                .collect(Collectors.toList());

        MatchingResult matchingResult = new ResultFactory().createMatchingResult(schemas.toArray(new Schema[0]));

        //run executor
        ExecutorFactory.newMatchingExecutor(null,  null, null).run();


        matchingResult.save("..\\result\\actual-result.xml");
    }
}
