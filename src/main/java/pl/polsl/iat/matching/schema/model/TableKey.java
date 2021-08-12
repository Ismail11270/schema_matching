package pl.polsl.iat.matching.schema.model;


public enum TableKey {
    PK(CharacteristicType.PrimaryKey), FK(CharacteristicType.ForeignKey);

    private final CharacteristicType generalType;

    TableKey(CharacteristicType type){
        generalType = type;
    }

    public CharacteristicType getGeneralType(){
        return generalType;
    }

}