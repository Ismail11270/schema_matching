package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.executor.result.PartialResult;
import pl.polsl.iat.matching.result.Component;
import pl.polsl.iat.matching.result.MatchingResult;
import pl.polsl.iat.matching.schema.model.Schema;

import java.util.Random;
import java.util.concurrent.Callable;

public class TaskFactory {

    private final Random r = new Random();

    public TaskFactory() {
    }

    public Callable<PartialResult<Schema>> getTaskSchema(Schema first, Schema second, Component resultComponent) {
//        resultComponent.
        return () -> {
            Thread.sleep(5000);
            System.out.println(first.getName() + " " + second.getName() + " " + Thread.currentThread().getName());
            return new PartialResult<>(r.nextFloat());
        };
    }


}
