package pl.polsl.iat.matching.concurrency;

import pl.polsl.iat.matching.matchers.component.TableMatcher;

import java.util.Collection;
import java.util.Stack;

public class TableMatcherSupplier {

    private static TableMatcherSupplier instance;
    public static TableMatcherSupplier initialize(Collection<TableMatcher> initialMatchers) {
        return instance != null ? instance : (instance = new TableMatcherSupplier(initialMatchers));
    }

    private final Stack<TableMatcher> availableMatchers = new Stack<>();
    private boolean isAvailable;

    private TableMatcherSupplier(Collection<TableMatcher> initialMatchers) {
        this.availableMatchers.addAll(initialMatchers);
        isAvailable = true;
    }

    public synchronized TableMatcher getTableMatcherWhenAvailable() {
        if (availableMatchers.isEmpty()) {
            isAvailable = false;
        }

        while(!isAvailable) {
            try {
                wait();
            } catch (InterruptedException e) {
                System.out.println("Interrupted " + Thread.currentThread().getName());
                Thread.currentThread().interrupt();
            }
        }
        return availableMatchers.pop();
    }

    public synchronized void releaseMatcher(TableMatcher matcher) {
        availableMatchers.push(matcher);
        isAvailable = true;
        notify();
    }

}
