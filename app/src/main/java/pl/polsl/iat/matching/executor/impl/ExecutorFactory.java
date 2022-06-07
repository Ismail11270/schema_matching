package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.core.model.result.MatchingResult;
import pl.polsl.iat.matching.core.model.schema.Schema;

import java.util.List;


public class ExecutorFactory {
    public static SchemaMatcherRunner newSchemaMatchingExecutor(MatchingResult mainResult, Schema... schemas) {
        return new SchemaMatcherRunner(schemas[0], schemas[1], mainResult);
    }



//    public static MatcherRunner newTableMatchingExecutor(Table left, Table right, MatchingResult mainResult) {
//        return new MatcherRunner(List.of(left,right));
//    }
}