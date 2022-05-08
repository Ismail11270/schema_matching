package pl.polsl.iat.matching.concurrency;

@Deprecated
public class TableMatcherSupplier {
/*
    private static TableMatcherSupplier instance;
    public static TableMatcherSupplier initialize(Collection<ComponentMatcher<Table>> initialMatchers) {
        return instance != null ? instance : (instance = new TableMatcherSupplier(initialMatchers));
    }

    private final Stack<ComponentMatcher<Table>> availableMatchers = new Stack<>();
    private boolean isAvailable;

    private TableMatcherSupplier(Collection<ComponentMatcher<Table>> initialMatchers) {
        this.availableMatchers.addAll(initialMatchers);
        isAvailable = true;
    }

    public synchronized ComponentMatcher<Table> getTableMatcherWhenAvailable() {
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

    public synchronized void releaseMatcher(ComponentMatcher<Table> matcher) {
        availableMatchers.push(matcher);
        isAvailable = true;
        notify();
    }*/

}
