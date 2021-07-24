package pl.polsl.iat.matching.schema.model;

public interface Table extends ComponentsProvider, ChildComponent {
    String getName();
    int getColumnsNumber();
}
