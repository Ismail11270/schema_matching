package pl.polsl.iat.matching.core.model.schema;

import java.util.List;

public class KeyCharacteristic implements Characteristic<TableKey, List<BaseCharacteristic<String>>>{
    private List<BaseCharacteristic<String>> childCharacteristics;
    private TableKey key;

    public KeyCharacteristic(TableKey key, List<BaseCharacteristic<String>> chars){
        this.key = key;
        this.childCharacteristics = chars;
    }

    @Override
    public List<BaseCharacteristic<String>> getValue() {
        return childCharacteristics;
    }

    @Override
    public TableKey getKey() {
        return key;
    }

    @Override
    public CharacteristicType getCharacteristicType() {
        return key.getGeneralType();
    }

    @Override
    public String toString() {
        return key.name() + "=List<BaseCharacteristic<String>>(" + childCharacteristics.size() + ")";
    }
}
