package pl.polsl.iat.matching.schema.model;

public interface Attribute<T> {
    String attributeName();
    T getValue();
    AttributeType getType();
}
