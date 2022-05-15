package pl.polsl.iat.matching.core.sql;

import com.microsoft.sqlserver.jdbc.SQLServerDriver;
import com.mysql.cj.jdbc.Driver;

import java.sql.DriverManager;
import java.sql.SQLException;

public class SqlUtil {

    public static String buildConnectionAddress(ConnectionProperties properties) throws SQLException {
        StringBuilder urlBuilder = new StringBuilder("jdbc:").append(properties.getDatabaseType().prefix).append("://").append(properties.getUrl());
        if(properties.getDatabaseType() == DatabaseType.MYSQL) {
            DriverManager.registerDriver(new Driver());
            return urlBuilder.append("/").append(properties.getSchemaName()).toString();
        }
        else if(properties.getDatabaseType() == DatabaseType.SQLSERVER) {
            DriverManager.registerDriver(new SQLServerDriver());
            return urlBuilder.append(";instanceName=").append(properties.getProperty("instance_name")).append(";encrypt=false;").toString();
        }
        return null;
    }

}
