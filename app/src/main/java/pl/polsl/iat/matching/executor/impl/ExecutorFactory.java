package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.core.model.result.MatchingResult;
import pl.polsl.iat.matching.core.model.schema.Schema;

import java.util.ArrayList;
import java.util.List;


public class ExecutorFactory {
    public static List<SchemaMatcherRunner> newSchemaMatchingExecutor(MatchingResult mainResult, Schema... schemas) {
        List<SchemaMatcherRunner> runners = new ArrayList<>();
        for(int i = 0; i < schemas.length - 1; i++) {
            for(int j = i + 1, k = 0; j < schemas.length && k < mainResult.getComponents().get(i).getMatchingComponent().size(); j++, k++) {
                runners.add(new SchemaMatcherRunner(schemas[i], schemas[j], mainResult.getComponents().get(i).getMatchingComponent().get(k)));
            }
        }
        return runners;
    }

}