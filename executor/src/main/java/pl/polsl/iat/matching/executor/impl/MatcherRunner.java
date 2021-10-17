package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.executor.result.PartialResult;
import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.result.ResultFactory;
import pl.polsl.iat.matching.schema.model.Schema;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
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
            List<Future<PartialResult<Schema>>> futures = new ArrayList<>();



            for(int i = 0; i < schemas.size(); i++) {
                for(int j = i+1; j < schemas.size(); j++) {
                    futures.add(service.submit(factory.getTaskSchema(schemas.get(i), schemas.get(j), matchingResult.getComponent())));
                }
            }

            futures.stream().forEach(x -> {
                try {
                    System.out.println(x.get().getResult());
                } catch (InterruptedException | ExecutionException e) {
                    e.printStackTrace();
                }
            });

        } catch (Throwable t) {

        } finally {
            service.shutdownNow();
        }
    }
}
