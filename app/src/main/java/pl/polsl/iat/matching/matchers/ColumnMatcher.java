package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Component;
import pl.polsl.iat.matching.matchers.result.Results;

public class ColumnMatcher extends ComponentMatcher{

    private static final ColumnMatcher instance = new ColumnMatcher();
    public static ColumnMatcher getInstance() {
        return instance;
    }

    @Override
    public Results doMatch(Component left, Component  right) {
        return super.doMatch(left,right);
    }

}
