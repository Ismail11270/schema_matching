package pl.polsl.iat.matching.sql;

import java.util.Date;
import java.util.Map;

public enum DataType {
    //String
    CHAR(String.class), VARCHAR(String.class), BINARY(String.class), VARBINARY(String.class), TINYBLOB(String.class), TINYTEXT(String.class), TEXT(String.class),
    BLOB(String.class), MEDIUMTEXT(String.class), MEDIUMBLOB(String.class), LONGTEXT(String.class), LONGBLOB(String.class), ENUM(String.class), SET(String.class),

    //INT
    BIT(Integer.class), TINYINT(Integer.class), SMALLINT(Integer.class), MEDIUMINT(Integer.class), INT(Integer.class), INTEGER(Integer.class), BIGINT(Integer.class),

    //BOOLEAN
    BOOL(Boolean.class), BOOLEAN(Boolean.class),

    //DECIMAL
    FLOAT(Double.class), DOUBLE(Double.class), DECIMAL(Double.class), DEC(Double.class),

    //DATE-TIME
    DATE(Date.class), DATETIME(Date.class), TIMESTAMP(Date.class), TIME(Date.class), YEAR(Date.class);


    private Class javaType;

    DataType(Class javaType){
        this.javaType = javaType;
    }

    public Class getJavaType(){
        return javaType;
    }
}
