package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Component;
import pl.polsl.iat.matching.core.util.Const;
import pl.polsl.iat.matching.matchers.result.Results;
import pl.polsl.iat.matching.util.Logger;

public class TableMatcher extends ComponentMatcher {

    private static final TableMatcher instance = new TableMatcher();
    public static TableMatcher getInstance() {
        return instance;
    }

    @Override
    protected Object getNameCharacteristicsKey() {
        return Const.CharName.TABLE_NAME;
    }

    @Override
    public Results doMatch(Component left, Component  right) {
        Results results = super.doMatch(left, right);
        Logger.table(left.getName() + " == " + right.getName() + " = " + results.calculateResult());
        return results;
    }
}
