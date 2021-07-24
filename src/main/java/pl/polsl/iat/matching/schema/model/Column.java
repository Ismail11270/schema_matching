package pl.polsl.iat.matching.schema.model;

public interface Column extends AttributesProvider {

    String getName();

    ColumnType getType();

    Constraints getConstraints();

}
