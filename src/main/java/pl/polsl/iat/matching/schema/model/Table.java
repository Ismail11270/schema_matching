package pl.polsl.iat.matching.schema.model;

public interface Table extends ComponentsProvider<Column> {
    String getName();
    int getColumnsNumber();
}
