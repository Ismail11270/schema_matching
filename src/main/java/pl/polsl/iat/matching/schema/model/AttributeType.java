package pl.polsl.iat.matching.schema.model;

public enum AttributeType {
    Name(0.8f), Type(0.05f),
    Date(0.01f), PrimaryKey(0.5f),
    ForeignKey(0.1f), Default(0.3f),
    Nullable(0.1f);

    private final float similarityCoef;

    AttributeType(float similarityCoef){
        this.similarityCoef = similarityCoef;
    }

    public float getSimilarityCoef() {
        return this.similarityCoef;
    }
}
