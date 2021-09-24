package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.schema.model.Schema;

import java.util.List;


public class ExecutorFactory {
    public static MatcherRunner newMatchingExecutor(Schema schemaA, Schema schemaB, MatchingResult mainResult) {
        return new MatcherRunner(List.of(schemaA, schemaB));
    }
}