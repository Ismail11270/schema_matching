package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.util.Const;

public class TableMatcher extends ComponentMatcher {

    private static final TableMatcher instance = new TableMatcher();
    public static TableMatcher getInstance() {
        return instance;
    }

    @Override
    protected Object getNameCharacteristicsKey() {
        return Const.CharName.TABLE_NAME;
    }
}
