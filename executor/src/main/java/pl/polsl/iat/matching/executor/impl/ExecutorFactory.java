package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.Table;

import java.util.List;


public class ExecutorFactory {
    public static MatcherRunner newSchemaMatchingExecutor(Schema schemaA, Schema schemaB, MatchingResult mainResult) {
        return new MatcherRunner(List.of(schemaA, schemaB));
    }



//    public static MatcherRunner newTableMatchingExecutor(Table left, Table right, MatchingResult mainResult) {
//        return new MatcherRunner(List.of(left,right));
//    }
}