package pl.polsl.iat.matching.schema.model.impl;

import pl.polsl.iat.matching.exception.SchemaExtractorException;
import pl.polsl.iat.matching.schema.model.*;
import pl.polsl.iat.matching.util.Const;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class SchemaImpl implements Schema {
    private Stream<Table> tablesStream;
    private List<Table> tablesList;
    private BasicCharacteristic schemaName;
    private boolean loaded;

    private SchemaImpl(){
    }

    @Override
    public Stream<Characteristic<?>> getCharacteristics() {
        return Stream.of(schemaName);
    }

    @Override
    public Stream<Table> getComponents() {
        return loaded ? tablesList.stream() : tablesStream;
    }

    /**
     * @return name of the schema extracted from attributes list
     */
    @Override
    public String getName() {
        return schemaName.getValue();
    }

    static class Builder{
        private final SchemaImpl schema = new SchemaImpl();
        private final SchemaExtractor.Mode loaderMode;

        public Builder(SchemaExtractor.Mode loaderMode){
            this.loaderMode = Objects.requireNonNull(loaderMode);
        }

        public Builder setName(String schemaName){
            schema.schemaName = new BasicCharacteristic(Const.CharName.SCHEMA_NAME, schemaName, CharacteristicType.Name);
            return this;
        }

        public Builder setTablesSource(Stream<Table> tableStream){
            if(loaderMode == SchemaExtractor.Mode.LAZY) {
                schema.tablesStream = tableStream;
                schema.loaded = false;
            } else {
                schema.tablesList = tableStream.collect(Collectors.toList());
                schema.loaded = true;
            }
            return this;
        }

        public Schema build() {
            if(schema.tablesList == null && schema.tablesStream == null){
                throw new SchemaExtractorException("Table data now provided for schema");
            }
            if(schema.schemaName == null) {
                throw new SchemaExtractorException("Schema name is missing");
            }
            return schema;
        }
    }


}
