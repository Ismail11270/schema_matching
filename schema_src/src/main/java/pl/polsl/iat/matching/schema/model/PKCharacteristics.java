package pl.polsl.iat.matching.schema.model;

/**
 * List of loaded primary key characteristics
 *
 * Delete or add based on  {@link java.sql.DatabaseMetaData} getPrimaryKeys method
 */
public enum PKCharacteristics {
    TABLE_CAT,
    TABLE_SCHEM,
    TABLE_NAME,
    COLUMN_NAME,
    KEY_SEQ,  //short => sequence number within primary key( a value of 1 represents the first column of
              // the primary key, a value of 2 would represent the second column within the primary key).
    PK_NAME;


    //TODO Do I need to define type for each characteristic?
    public static CharacteristicType getCharacteristicType() {
        return CharacteristicType.PrimaryKey;
    }

}
