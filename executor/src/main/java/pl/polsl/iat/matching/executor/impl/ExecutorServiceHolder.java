package pl.polsl.iat.matching.executor.impl;

import java.util.concurrent.TimeUnit;

public class ExecutorServiceHolder{
    private ComponentMatchingExecutor availableExecutor;

    private static ExecutorServiceHolder instance;

    private final int SHUTDOWN_TIMEOUT = 50;

    private ExecutorServiceHolder() {

    }

    public static ExecutorServiceHolder getInstance() {
        return instance == null ? instance : (instance = new ExecutorServiceHolder());
    }

    private void initExecutor() {
        if(availableExecutor == null || availableExecutor.isShutdown() || availableExecutor.isTerminated()) {
            availableExecutor = new ComponentMatchingExecutor(Runtime.getRuntime().availableProcessors());
        }
    }

    public ComponentMatchingExecutor getAvailableExecutor() {
        initExecutor();
        return availableExecutor;
    }

    public void initiateShutdown() {
        availableExecutor.shutdown();
        try {
            if (!availableExecutor.awaitTermination(SHUTDOWN_TIMEOUT, TimeUnit.SECONDS)) {
                availableExecutor.shutdownNow();
            }
        } catch (InterruptedException e) {
            availableExecutor.shutdownNow();
        }
    }
}
