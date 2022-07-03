package pl.polsl.iat.matching.core.sql;

import com.microsoft.sqlserver.jdbc.SQLServerDriver;
import com.mysql.cj.jdbc.Driver;

import java.io.PrintStream;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SqlUtil {

    public static String buildConnectionAddress(ConnectionProperties properties) throws SQLException {
        StringBuilder urlBuilder = new StringBuilder("jdbc:").append(properties.getDatabaseType().prefix).append("://").append(properties.getUrl());
        if (properties.getDatabaseType() == DatabaseType.MYSQL) {
            DriverManager.registerDriver(new Driver());
            return urlBuilder.append("/").append(properties.getSchemaName()).toString();
        } else if (properties.getDatabaseType() == DatabaseType.SQLSERVER) {
            DriverManager.registerDriver(new SQLServerDriver());
            return urlBuilder.append(";instanceName=").append(properties.getProperty("instance_name")).append(";encrypt=false;").toString();
        }
        return null;
    }

    public static void printResultSet(ResultSet rs, PrintStream output) {
        try {
            int columnCount = rs.getMetaData().getColumnCount();
            for (int i = 1; i < columnCount; i++) {
                String columnLabel = rs.getMetaData().getColumnLabel(i);
                Object value = rs.getObject(i);
                System.out.println(columnLabel + " " + value);
            }
        } catch (Exception e) {
            Logger.getLogger(SqlUtil.class.getName()).log(Level.WARNING, "Error during printing out result set");
        }
    }
}