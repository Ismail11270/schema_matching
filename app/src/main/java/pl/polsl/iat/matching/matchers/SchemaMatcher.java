package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.Schema;
import pl.polsl.iat.matching.core.util.Const;

public class SchemaMatcher extends ComponentMatcher<Schema> {

    private static final SchemaMatcher instance = new SchemaMatcher();
    public static SchemaMatcher getInstance() {
        return instance;
    }


    @Override
    protected Object getNameCharacteristicsKey() {
        return Const.CharName.SCHEMA_NAME;
    }
}
