package pl.polsl.iat.matching.core.schema.model.impl;

import pl.polsl.iat.matching.core.exception.SchemaExtractorException;
import pl.polsl.iat.matching.core.schema.model.*;
import pl.polsl.iat.matching.core.util.Const;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class SchemaImpl implements Schema {
    private static final ComponentType type = ComponentType.SCHEMA;
    private Stream<Table> tablesStream;
    private List<Table> tablesList;
    private StringCharacteristic schemaName;
    private boolean loaded;

    private SchemaImpl(){
    }

    @Override
    public Stream<BaseCharacteristic<?>> getCharacteristics() {
        return Stream.of(schemaName);
    }

    @Override
    public List<Table> getComponents() {
        loadComponents();
        return tablesList;
    }

    private void loadComponents() {
        if(!loaded){
            tablesList = tablesStream.collect(Collectors.toList());
            loaded = true;
        }
    }
    /**
     * @return name of the schema extracted from attributes list
     */
    @Override
    public String getName() {
        return schemaName.getValue();
    }

    @Override
    public ComponentType getComponentType() {
        return type;
    }

    static class Builder{
        private final SchemaImpl schema = new SchemaImpl();
        private final SchemaExtractor.Mode loaderMode;

        public Builder(SchemaExtractor.Mode loaderMode){
            this.loaderMode = Objects.requireNonNull(loaderMode);
        }

        public Builder setName(String schemaName){
            schema.schemaName = new StringCharacteristic(Const.CharName.SCHEMA_NAME, schemaName, CharacteristicType.TableName);
            return this;
        }

        public Builder setTablesSource(Stream<Table> tablesStream){
            if(loaderMode == SchemaExtractor.Mode.LAZY) {
                schema.tablesStream = tablesStream;
                schema.loaded = false;
            } else {
                schema.tablesList = tablesStream.collect(Collectors.toList());
                schema.loaded = true;
            }
            return this;
        }

        public Builder setTablesList(List<Table> tablesList){
            schema.loaded = true;
            schema.tablesList = tablesList;
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
