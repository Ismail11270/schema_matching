package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.core.model.result.MatchingComponent;
import pl.polsl.iat.matching.core.model.schema.Schema;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Future;

public class SchemaMatcherRunner {

    private final Schema schemaLeft, schemaRight;

    private final ComponentMatchingExecutor service;

    private final MatchingComponent schemaResultMatchingComponent;

    private final List<Future<Float>> results = new ArrayList<>();

    SchemaMatcherRunner(Schema left, Schema right, MatchingComponent schemaResultMatchingComponent) {
        this.schemaLeft = left;
        this.schemaRight = right;
        this.schemaResultMatchingComponent = schemaResultMatchingComponent;
        this.service = ExecutorServiceHolder.getInstance().getAvailableExecutor();
    }

    public void run() {
        try {
            MatchTaskManager taskManager = MatchTaskManager.getInstance();
            List<Future<Boolean>> futures = new ArrayList<>(service.invokeAll(
                    taskManager.getTasksForSchemaPair(schemaLeft, schemaRight,
                            schemaResultMatchingComponent)));


//            taskManager.getTasksForSchemaPair(schemaLeft, schemaRight,
//                    schemaResultMatchingComponent).forEach(service::submit);
//            service.awaitTermination(20, TimeUnit.SECONDS);
//            service.shutdown();
        } catch (Throwable t) {
            System.out.println(t.getMessage());
        } finally {
//            service.shutdownNow();
        }
    }
}
