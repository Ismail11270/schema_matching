package pl.polsl.iat.matching.core.model.schema;

/**
 * Enum holding names of all column attributes that are loaded
 * @see java.sql.DatabaseMetaData getColumns() method documentation for the list of possible characteristics
 */
public enum ColumnCharacteristicType {
    TABLE_CAT(CharacteristicType.SchemaName),
    TABLE_NAME(CharacteristicType.TableName),
    COLUMN_NAME(CharacteristicType.ColumnName),
    DATA_TYPE(CharacteristicType.Type),
    COLUMN_SIZE(CharacteristicType.Ignored),
    IS_NULLABLE(CharacteristicType.Nullable),
    IS_AUTOINCREMENT(CharacteristicType.AutoIncrement),
    COLUMN_DEF(CharacteristicType.Default),
    IS_GENERATEDCOLUMN(CharacteristicType.Ignored);

    private CharacteristicType generalType;

    ColumnCharacteristicType(CharacteristicType type) {
        generalType = type;
    }

    public CharacteristicType getGeneralType(){
        return generalType;
    }
}