package pl.polsl.iat.matching.matchers.result;

import pl.polsl.iat.matching.core.model.schema.ColumnCharacteristicType;

public class CharacteristicsResult extends AbstractResult<Integer> {

    private final int result;
    private final ColumnCharacteristicType type;

    public CharacteristicsResult(ColumnCharacteristicType type, int result) {
        this.result = result;
        this.type = type;
    }

    @Override
    public Integer getResult() {
        return result;
    }

    @Override
    public float getWeight() {
        return type.getGeneralType().getPositiveCoef();
    }

    public ColumnCharacteristicType getType() {
        return type;
    }
}
