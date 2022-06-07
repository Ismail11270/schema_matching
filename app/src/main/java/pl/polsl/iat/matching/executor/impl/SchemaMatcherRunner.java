package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.core.model.result.MatchingResult;
import pl.polsl.iat.matching.core.model.schema.Schema;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Future;

public class SchemaMatcherRunner {

    private final Schema schemaLeft, schemaRight;

    private final ComponentMatchingExecutor service;

    private final MatchingResult matchingResult;

    private final List<Future<Float>> results = new ArrayList<>();

    SchemaMatcherRunner(Schema left, Schema right, MatchingResult matchingResult) {
        this.schemaLeft = left;
        this.schemaRight = right;
        this.matchingResult = matchingResult;
        this.service = ExecutorServiceHolder.getInstance().getAvailableExecutor();
    }

    public void run() {
        try {
            MatchTaskManager taskManager = MatchTaskManager.getInstance();
            List<Future<Boolean>> futures = new ArrayList<>(service.invokeAll(
                    taskManager.getTasksForSchemaPair(schemaLeft, schemaRight,
                            matchingResult.getComponents().get(0).getMatchingComponent().get(1))));

            //TODO detect best matches
        } catch (Throwable t) {
            System.out.println(t.getMessage());
        } finally {
            service.shutdown();
        }
    }
}
