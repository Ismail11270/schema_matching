package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.schema.model.Schema;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Future;

public class SchemaMatcherRunner {

    private final List<Schema> schemas;

    private final ComponentMatchingExecutor service;

    private final MatchingResult matchingResult;

    private List<Future<Float>> results = new ArrayList<>();

    SchemaMatcherRunner(List<Schema> schemas, MatchingResult matchingResult) {
        this.schemas = schemas;
        this.matchingResult = matchingResult;
        this.service = ExecutorServiceHolder.getInstance().getAvailableExecutor();
    }

    public void run() {
        try {
            MatchTaskManager taskManager = MatchTaskManager.getInstance();
            List<Future<Boolean>> futures = new ArrayList<>();

            long startTime = System.currentTimeMillis();
            for (int i = 0; i < schemas.size(); i++) {
                for (int j = i + 1, k = 0; j < schemas.size(); j++, k++) {
                    System.out.println(i + " i - j " + j);
                    futures.addAll(service.invokeAll(
                            taskManager.getTasksForSchemaPair(schemas.get(i), schemas.get(j),
                                    matchingResult.getComponents().get(i).getMatchingComponent().get(k))));
                }
            }
            System.out.println(System.currentTimeMillis() - startTime);
            matchingResult.getComponents().get(0).getMatchingComponent().get(0).setCombinedScore(50);


            //TODO detect best matches
        } catch (Throwable t) {
            System.out.println(t.getMessage());
        } finally {
            service.shutdown();
        }
    }
}
