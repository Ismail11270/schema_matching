package pl.polsl.iat.thesis.sql;

public enum DatabaseType {

    MYSQL("mysql"), ORACLE, POSTGRES;

    String prefix;

    DatabaseType(String prefix){
        this.prefix = prefix;
    }

    DatabaseType(){
        prefix = "";
    }
}
