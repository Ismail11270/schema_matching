package pl.polsl.iat.thesis.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcConnection {

    private Connection connection;

    public JdbcConnection(ConnectionProperties properties){
        try {
            connection = DriverManager.getConnection(SqlUtil.buildConnectionAddress(properties),properties.getUsername(),properties.getPassword());
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
