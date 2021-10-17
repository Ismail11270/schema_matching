package pl.polsl.iat.matching.executor;

import pl.polsl.iat.matching.executor.impl.ExecutorFactory;
import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.result.ResultFactory;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.impl.SchemaExtractor;
import pl.polsl.iat.matching.util.MatcherSettings;
import pl.polsl.iat.matching.util.ParametersResolver;

public class Main {

    public static void main(String[] args) {
        ParametersResolver parametersResolver = new ParametersResolver(args);

        Schema[] schemas = parametersResolver.getConnectionProperties()
                .stream()
                .map(p -> new SchemaExtractor(p).load(MatcherSettings.loaderMode))
                .toArray(Schema[]::new);

        MatchingResult matchingResult =
                new ResultFactory().createMatchingResult(schemas);


//        ThreadPoolExecutor executor =  new ThreadPoolExecutor(Runtime.getRuntime().availableProcessors(),
//                Runtime.getRuntime().availableProcessors(),
//                0L, TimeUnit.MILLISECONDS,
//                new LinkedBlockingQueue<Runnable>());
//        TaskFactory tasks = new TaskFactory(matchingResult);
        //run executor

        //TODO ADD SUPPORT FOR N NUMBER OF SCHEMAS
        ExecutorFactory.newSchemaMatchingExecutor(matchingResult, schemas).run();



        matchingResult.save("..\\result\\actual-result.xml");
    }
}
