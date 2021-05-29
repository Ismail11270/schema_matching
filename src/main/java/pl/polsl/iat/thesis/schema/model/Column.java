package pl.polsl.iat.thesis.schema.model;

public interface Column extends AttributesProvider {

    String getName();

    ColumnType getType();

    Constraints getConstraints();

}
