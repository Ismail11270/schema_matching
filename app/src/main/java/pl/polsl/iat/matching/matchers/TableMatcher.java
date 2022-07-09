package pl.polsl.iat.matching.matchers;

public class TableMatcher extends ComponentMatcher {

    private static final TableMatcher instance = new TableMatcher();
    public static TableMatcher getInstance() {
        return instance;
    }
}
