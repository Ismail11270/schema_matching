package pl.polsl.iat.thesis.schema.model;

public interface Column {

    String getName();

    Type getType();

    Constraints getConstraints();

}
