package pl.polsl.iat.thesis.sql;

import java.util.Locale;

public enum DatabaseType {

    MYSQL("mysql"), ORACLE, POSTGRES;

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
