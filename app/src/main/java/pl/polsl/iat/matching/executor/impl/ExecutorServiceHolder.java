package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.Objects;
import java.util.concurrent.TimeUnit;

public class ExecutorServiceHolder{
    private ComponentMatchingExecutor availableExecutor;

    private static ExecutorServiceHolder instance;

    private final int SHUTDOWN_TIMEOUT = 50;

    private ExecutorServiceHolder() {

    }

    public static ExecutorServiceHolder getInstance() {
        return instance != null ? instance : (instance = new ExecutorServiceHolder());
    }

    private void initExecutor() {
        if(availableExecutor == null || availableExecutor.isShutdown() || availableExecutor.isTerminated()) {
            availableExecutor = new ComponentMatchingExecutor(
                    Objects.requireNonNullElse(
                            MatcherSettings.getSettings().getNumberOfThreads(),
                            Runtime.getRuntime().availableProcessors()));
        }
    }

    public ComponentMatchingExecutor getAvailableExecutor() {
        initExecutor();
        return availableExecutor;
    }

    public void initiateShutdown() {
        availableExecutor.shutdown();
    }
}
