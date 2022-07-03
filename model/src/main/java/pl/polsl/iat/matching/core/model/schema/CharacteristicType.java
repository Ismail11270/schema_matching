package pl.polsl.iat.matching.core.model.schema;

public enum CharacteristicType {
    SchemaName(0.1f),
    TableName(0.8f), TableSchemaName(0.1f), ColumnName(0.2f),
    Type(0.05f), AutoIncrement(0.1f),
    Date(0.01f), PrimaryKey(0.5f),
    ForeignKey(0.1f), Default(0.3f),
    Nullable(0.1f), Other(0), Ignored(-1);

    private final float similarityCoef;

    CharacteristicType(float similarityCoef){
        this.similarityCoef = similarityCoef;
    }

    public float getSimilarityCoef() {
        return this.similarityCoef;
    }
}
