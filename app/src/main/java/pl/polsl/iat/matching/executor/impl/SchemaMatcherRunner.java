package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.core.model.result.MatchingComponent;
import pl.polsl.iat.matching.core.model.schema.Schema;
import pl.polsl.iat.matching.util.Logger;

import java.util.ArrayList;
import java.util.IntSummaryStatistics;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.stream.Collectors;

public class SchemaMatcherRunner {

    private final Schema schemaLeft, schemaRight;

    private ComponentMatchingExecutor service;

    private final MatchingComponent schemaResultMatchingComponent;

    private final List<Future<Float>> results = new ArrayList<>();

    SchemaMatcherRunner(Schema left, Schema right, MatchingComponent schemaResultMatchingComponent) {
        this.schemaLeft = left;
        this.schemaRight = right;
        this.schemaResultMatchingComponent = schemaResultMatchingComponent;
    }

    public void run() {
        try {
            this.service = ExecutorServiceHolder.getInstance().getAvailableExecutor();
            MatchTaskManager taskManager = MatchTaskManager.getInstance();
            List<Future<Integer>> futures = new ArrayList<>(service.invokeAll(
                    taskManager.getTasksForSchemaPair(schemaLeft, schemaRight,
                            schemaResultMatchingComponent)));
            double average = futures.stream().collect(Collectors.summarizingInt(this::getFutureInt)).getAverage();
            Logger.schema("Schema total %s", average + "");
        } catch (Throwable t) {
            System.out.println(t.getMessage());
        } finally {
            service.shutdownNow();
        }
    }

    private Integer getFutureInt(Future<Integer> futureInt) {
        try {
            if(futureInt.isDone() && !futureInt.isCancelled()) {
                return futureInt.get();
            }
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
