package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.core.model.result.MatchingResult;
import pl.polsl.iat.matching.core.model.schema.Schema;

import java.util.ArrayList;
import java.util.List;


public class ExecutorFactory {
    public static List<SchemaMatcherRunner> newSchemaMatchingExecutor(MatchingResult mainResult, Schema... schemas) {
        List<SchemaMatcherRunner> runners = new ArrayList<>();
        for(int i = 0; i < schemas.length - 1; i++) {
            for(int j = i + 1; j < schemas.length; j++) {
                runners.add(new SchemaMatcherRunner(schemas[i], schemas[j], mainResult.getComponents().get(i).getMatchingComponent().get(schemas.length-j-1)));
            }
        }
        return runners;
    }



//    public static MatcherRunner newTableMatchingExecutor(Table left, Table right, MatchingResult mainResult) {
//        return new MatcherRunner(List.of(left,right));
//    }
}