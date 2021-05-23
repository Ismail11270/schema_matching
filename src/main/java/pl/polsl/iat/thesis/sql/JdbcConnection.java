package pl.polsl.iat.thesis.sql;

import pl.polsl.iat.thesis.exception.DatabaseException;
import pl.polsl.iat.thesis.sql.query.GeneralQuery;

import java.sql.*;

public class JdbcConnection {

    private Connection connection;
    private ConnectionProperties properties;

    public JdbcConnection(ConnectionProperties properties) throws DatabaseException {
        try {
            this.properties = properties;
            this.properties.setUrl(SqlUtil.buildConnectionAddress(properties));
            String url = properties.getUrl().orElseThrow(() -> new DatabaseException("JDBC Url generated is null for " + properties.getHost() + ":" + properties.getPort()));
            connection = DriverManager.getConnection((url), properties.getUsername(), properties.getPassword());
        } catch (SQLException e) {
            throw new DatabaseException("Error creating a database connection. ", e);
        }
    }

    public void whatTables() {
        try {
            String[] columns = {"TABLE_SCHEMA", "TABLE_NAME", "TABLE_ROWS", "CREATE_TIME"};
            ResultSet resultSet = connection.createStatement().executeQuery(GeneralQuery.listTablesForSchema(properties.getSchemaName(),columns));
            while(resultSet.next()){
                for(String c : columns) {
                    System.out.print(resultSet.getString(c) + ", ");
                }
                System.out.println();
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public void test_metadata() throws SQLException {
        DatabaseMetaData metaData = connection.getMetaData();
        System.out.println(metaData.getDatabaseProductName());
//        ResultSet catalogs = metaData.getCatalogs();
        ResultSet resultSet = metaData.getTables("university", null, null, new String[]{"TABLE"});
        while(resultSet.next()) {
            String tableName = resultSet.getString("TABLE_NAME");
            String remarks = resultSet.getString("REMARKS");
            System.out.println(tableName + " " + remarks);
        }
        System.out.println(metaData.getMaxColumnsInIndex());
    }
}
