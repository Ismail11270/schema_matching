package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.result.MatchingResult;

import java.util.concurrent.*;

public class ComponentMatchingExecutor extends ThreadPoolExecutor {

    public ComponentMatchingExecutor(int poolSize) {
        super(poolSize, poolSize, 0L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue<Runnable>());
    }

    public MatchingResult getResult() {
        return null;
    }
}
