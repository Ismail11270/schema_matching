package pl.polsl.iat.matching.util;

public class Const {
    public static class CharName {
        public static final String SCHEMA_NAME = "SchemaName";
        public static final String TABLE_NAME = "TableName";
        public static final String COLUMN_NAME = "ColumnName";
        public static final String COLUMN_TYPE = "ColumnType";
        public static final String COLUMN_PRIMARY_KEY = "PrimaryKey";
        public static final String COLUMN_DEFAULT = "DEFAULT";
        public static final String COLUMN_NULLABLE = "NULLABLE";
        public static final String COLUMN_UNIQUE = "UNIQUE";
    }
    public static class ColumnName {
        public static final String GET_TABLES_TABLE_NAME = "TABLE_NAME";

        public static final String GET_TABLE_SCHEMA_NAME = "TABLE_SCHEM";
    }

    public static class SettingsXml {
        public static final String MATCHER_TAG = "matcher";
        public static final String TYPE_TAG = "type";
        public static final String ACTIVE_TAG = "active";
        public static final String MODE = "mode";
        public static final String MATCHER_SETTINGS_VAR = "MATCHER_SETTINGS_FILE";
        public static final String THREADS = "threads";
    }

}
