package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.schema.model.Schema;

import java.util.List;


public class ExecutorFactory {
    public static MatcherRunner newSchemaMatchingExecutor(MatchingResult mainResult, Schema... schemas) {
        return new MatcherRunner(List.of(schemas));
    }



//    public static MatcherRunner newTableMatchingExecutor(Table left, Table right, MatchingResult mainResult) {
//        return new MatcherRunner(List.of(left,right));
//    }
}