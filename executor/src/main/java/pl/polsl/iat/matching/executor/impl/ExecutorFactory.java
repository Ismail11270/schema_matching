package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.schema.model.Schema;

import java.util.List;


public class ExecutorFactory {
    public static SchemaMatcherRunner newSchemaMatchingExecutor(MatchingResult mainResult, Schema... schemas) {
        return new SchemaMatcherRunner(List.of(schemas), mainResult);
    }



//    public static MatcherRunner newTableMatchingExecutor(Table left, Table right, MatchingResult mainResult) {
//        return new MatcherRunner(List.of(left,right));
//    }
}