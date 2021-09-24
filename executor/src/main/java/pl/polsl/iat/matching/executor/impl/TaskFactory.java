package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.schema.model.Schema;

import java.util.concurrent.Callable;

public class TaskFactory {
    public Callable<Float> getTaskSchemas(Schema first, Schema second) {
        return () -> {
            return null;
        };
    }
}
