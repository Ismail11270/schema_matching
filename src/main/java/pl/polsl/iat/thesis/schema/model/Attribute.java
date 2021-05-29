package pl.polsl.iat.thesis.schema.model;

public interface Attribute<T> {
    T getValue();
    AttributeType getType();
}
