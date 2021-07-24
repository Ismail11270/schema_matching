package pl.polsl.iat.matching.schema;


import pl.polsl.iat.matching.exception.DatabaseException;
import pl.polsl.iat.matching.exception.RuntimeDatabaseException;
import pl.polsl.iat.matching.schema.model.Table;
import pl.polsl.iat.matching.schema.model.impl.SchemaExtractor;
import pl.polsl.iat.matching.schema.model.impl.TableExtractor;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class MetadataLoader {
    private DatabaseMetaData metadata;

    private TableExtractor tableExtractor;

    //TODO create table objects from resultset
    private Table prepareTable(ResultSet r) {
        return tableExtractor.load(r);
    };

    public MetadataLoader(DatabaseMetaData metadata){
        this.metadata = metadata;
        this.tableExtractor = new TableExtractor(metadata);
    }

    public Stream<Table> getTables(SchemaExtractor.Mode extractionMode) throws DatabaseException {
        Stream<Table> tableStream = getTables();
        if(extractionMode == SchemaExtractor.Mode.EAGER){
            return tableStream.collect(Collectors.toList()).stream();
        }
        return tableStream;
    }

    private Stream<Table> getTables() throws DatabaseException {
        try {
            ResultSet result = metadata.getTables(null, null, null, new String[] {"TABLE"});
            UnsafePredicate<ResultSet> hasNextTest = (r) -> {
                try {
                    return r.next();
                } catch(Exception e){
                    throw new RuntimeDatabaseException(e);
                }
            };
            if (hasNextTest.test(result)) {
                return Stream.iterate(prepareTable(result), t -> hasNextTest.test(result) , table -> prepareTable(result) );
            }
            else {
                return Stream.empty();
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to acquire schema tables metadata", e);
        }
    }


}
