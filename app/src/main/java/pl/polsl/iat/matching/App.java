package pl.polsl.iat.matching;

import pl.polsl.iat.matching.core.model.result.MatchingResult;
import pl.polsl.iat.matching.core.model.result.ResultFactory;
import pl.polsl.iat.matching.core.model.schema.Column;
import pl.polsl.iat.matching.core.model.schema.Schema;
import pl.polsl.iat.matching.core.model.schema.Table;
import pl.polsl.iat.matching.core.model.schema.impl.SchemaExtractor;
import pl.polsl.iat.matching.core.util.ParametersResolver;
import pl.polsl.iat.matching.executor.impl.ExecutorFactory;
import pl.polsl.iat.matching.util.MatcherSettings;

public class App {

    public static void main(String[] args) {
        ParametersResolver parametersResolver = new ParametersResolver(args);

        long startTime = System.currentTimeMillis();
        Schema[] schemas = parametersResolver.getConnectionProperties()
                .parallelStream()
                .map(p -> new SchemaExtractor(p).load(MatcherSettings.getSettings().getLoaderMode()))
                .toArray(Schema[]::new);

        System.out.println("Schema loading time - " + (System.currentTimeMillis() - startTime));

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

//
        Schema schema1 = schemas[0];
        Schema schema2 = schemas[1];
//
//
//        Table table1 = schemas[0].getComponents().get(0);
//        Table table2 = schemas[0].getComponents().get(1);
//
//        Column column1 = schemas[0].getComponents().get(0).getComponents().get(0);
//        Column column2 = schemas[0].getComponents().get(0).getComponents().get(1);


        System.out.println("Matching time - " + (System.currentTimeMillis() - startTime));

        matchingResult.save("result\\actual-result.xml");

        System.out.println("Total time - " + (System.currentTimeMillis() - startTime));

    }

    static class Matcher {
        private String text;

        public Matcher(String textToPrint) {
            text = textToPrint;
        }

        public void doMatch(String s) {
            System.out.println(text);
        }
    }
}
