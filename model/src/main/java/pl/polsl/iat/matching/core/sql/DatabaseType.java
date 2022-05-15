package pl.polsl.iat.matching.core.sql;


/**
 * Pls add {@link DataType} if required for new databases
 */
public enum DatabaseType {


    MYSQL("mysql"), ORACLE, POSTGRES, SQLSERVER("sqlserver");

    String prefix;

    DatabaseType(String prefix){
        this.prefix = prefix;
    }

    DatabaseType(){
        prefix = "";
    }

    public static DatabaseType getType(String type){
        return DatabaseType.valueOf(type.toUpperCase());
    }

}
