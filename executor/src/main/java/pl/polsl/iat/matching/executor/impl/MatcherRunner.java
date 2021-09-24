package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.result.ResultFactory;
import pl.polsl.iat.matching.schema.model.Schema;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Future;

public class MatcherRunner {

    private List<Schema> schemas;

    private ComponentMatchingExecutor service;

    private MatchingResult matchingResult;

    private List<Future<Float>> results = new ArrayList<>();

    MatcherRunner(List<Schema> schemas){
        this.schemas = schemas;
        this.matchingResult = new ResultFactory().createMatchingResult(schemas.toArray(Schema[]::new));
        this.service = ExecutorServiceHolder.getInstance().getAvailableExecutor();
    }

    public void run() {
        try {
            TaskFactory factory = new TaskFactory();
            var iterator = schemas.iterator();
            for(int i = 0; i < schemas.size(); i++) {
                for(int j = 0; j < schemas.size(); j++) {
                    service.submit(factory.getTaskSchemas(schemas.get(i), schemas.get(j)));
                }
            }
        } catch (Throwable t) {

        }
    }
}
