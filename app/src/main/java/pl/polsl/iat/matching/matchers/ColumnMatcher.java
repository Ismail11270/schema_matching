package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.core.model.schema.*;
import pl.polsl.iat.matching.matchers.result.CharacteristicsResult;
import pl.polsl.iat.matching.matchers.result.Results;
import pl.polsl.iat.matching.util.MatcherSettings;

public class ColumnMatcher extends ComponentMatcher<Column> {

    private static final ColumnMatcher instance = new ColumnMatcher();
    public static ColumnMatcher getInstance() {
        return instance;
    }

    @Override
    public Results doMatch(Column left, Column right) {
        Results results = super.doMatch(left, right);
        if(MatcherSettings.getSettings().checkMatchingOption(MatcherSettings.MatchingOption.METADATA)){
            ColumnCharacteristicType.typesToCompare
                    .forEach(type -> compareCharacteristics(type, left.getCharacteristics().get(type), right.getCharacteristics().get(type), results));
//            for (ColumnCharacteristicType columnCharacteristicType : ColumnCharacteristicType.typesToCompare) {
//                compareCharacteristics(
//                        left.getCharacteristics().get(columnCharacteristicType),
//                        right.getCharacteristics().get(columnCharacteristicType),
//                        results);
//            }
        }

        return results;
    }

    @Override
    protected Object getNameCharacteristicsKey() {
        return ColumnCharacteristicType.COLUMN_NAME;
    }

    private void compareCharacteristics(ColumnCharacteristicType type, BaseCharacteristic<?> left, BaseCharacteristic<?> right, Results results) {
        if(left == null || right == null)
            return;
//        String valLeft = left.getValue();
//        String valRight = right.getValue();
//        if(valLeft == null || valRight == null) {
//            return;
//        }
        results.add(new CharacteristicsResult(type, left.match(right)));
    }
}
