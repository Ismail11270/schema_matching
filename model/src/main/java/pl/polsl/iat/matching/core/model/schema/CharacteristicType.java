package pl.polsl.iat.matching.core.model.schema;

public enum CharacteristicType {
    SchemaName(0.0f),
    TableName(1f, 1f), TableSchemaName(0.1f), ColumnName(0.2f),
    Type(0.05f, 0.5f), AutoIncrement(0.1f),
    Date(0.01f), PrimaryKey(0.8f, 0.8f),
    ForeignKey(0.3f, 0.3f), Default(0.3f, 0.1f),
    Nullable(0.1f, 0.1f), Other(0), Ignored(-1);

    private final float positiveCoef;
    private final float negativeCoef;

    CharacteristicType(float positiveCoef){
        this(positiveCoef, 0);
    }

    CharacteristicType(float positiveCoef, float negativeCoef) {
        this.positiveCoef = positiveCoef;
        this.negativeCoef = negativeCoef;
    }

    public float getPositiveCoef() {
        return this.positiveCoef;
    }

    public float getNegativeCoef() {
        return negativeCoef;
    }
}
