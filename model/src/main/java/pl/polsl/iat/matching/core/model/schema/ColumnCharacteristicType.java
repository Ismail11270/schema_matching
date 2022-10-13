package pl.polsl.iat.matching.core.model.schema;

import java.util.Arrays;
import java.util.List;

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
    IS_GENERATEDCOLUMN(CharacteristicType.Ignored),
    PRIMARY_KEY(CharacteristicType.PrimaryKey),
    FOREIGN_KEY(CharacteristicType.ForeignKey);

    private CharacteristicType generalType;

    ColumnCharacteristicType(CharacteristicType type) {
        generalType = type;
    }

    public CharacteristicType getGeneralType(){
        return generalType;
    }

    static {
        typesToCompare = List.of(DATA_TYPE, COLUMN_DEF, PRIMARY_KEY, FOREIGN_KEY);
    }
    public static final List<ColumnCharacteristicType> typesToCompare;
}