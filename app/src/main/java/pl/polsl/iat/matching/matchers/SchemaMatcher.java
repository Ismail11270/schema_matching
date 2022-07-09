package pl.polsl.iat.matching.matchers;

public class SchemaMatcher extends ComponentMatcher {

    private static final SchemaMatcher instance = new SchemaMatcher();
    public static SchemaMatcher getInstance() {
        return instance;
    }

}
