package pl.polsl.iat.matching.core.schema.model;

public enum FKCharacteristics {
    PKTABLE_CAT,
    PKTABLE_SCHEM,
    PKTABLE_NAME,
    PKCOLUMN_NAME,
    FKTABLE_CAT,
    FKTABLE_SCHEM,
    FKTABLE_NAME,
    FKCOLUMN_NAME,
    KEY_SEQ,
    UPDATE_RULE,
    DELETE_RULE,
    FK_NAME,
    PK_NAME,
    DEFERRABILITY;


    //TODO Do I need to define type for each characteristic?
    public static CharacteristicType getCharacteristicType() {
        return CharacteristicType.ForeignKey;
    }
}
