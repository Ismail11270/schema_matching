package pl.polsl.iat.matching.sql;

import pl.polsl.iat.matching.exception.DatabaseException;
import pl.polsl.iat.matching.sql.query.GeneralQuery;

import java.sql.*;

public class SchemaConnection {

    private Connection connection;
    private ConnectionProperties properties;

    public SchemaConnection(ConnectionProperties properties) throws DatabaseException {
        try {
            this.properties = properties;
            this.properties.setUrl(SqlUtil.buildConnectionAddress(properties));
            String url = properties.getUrl().orElseThrow(() -> new DatabaseException("JDBC Url generated is null for " + properties.getHost() + ":" + properties.getPort()));
            connection = DriverManager.getConnection((url), properties.getUsername(), properties.getPassword());
        } catch (SQLException e) {
            throw new DatabaseException("Error creating a database connection. ", e);
        }
    }

    public ResultSet rawQuery(String query) throws SQLException {
        return connection.createStatement().executeQuery(query);
    }


    public ResultSet queryTablesMetadata() throws DatabaseException {
        try {
            String[] columns = {"TABLE_SCHEMA", "TABLE_NAME", "TABLE_ROWS", "CREATE_TIME"};
            String q = GeneralQuery.listTablesForSchema(properties.getSchemaName(), columns);
            return connection.createStatement().executeQuery(q);
        } catch (SQLException e) {
            throw new DatabaseException("Failed to extract tables metadata", e);
        }
    }

    public DatabaseMetaData getMetadata() throws DatabaseException {
        try {
            return connection.getMetaData();
        } catch (SQLException e) {
            throw new DatabaseException("Failed to get metadata for schema " + properties.getSchemaName(), e);
        }
    }

//    public ResultSet queryColumnsMetadata(){
//        return connection.getMetaData().getColumns()
//    }


    public void whatTables() {
        try {
            String[] columns = {"TABLE_SCHEMA", "TABLE_NAME", "TABLE_ROWS", "CREATE_TIME"};
            String q = GeneralQuery.listTablesForSchema(properties.getSchemaName(),columns);
            System.out.println(q);
            ResultSet resultSet = connection.createStatement().executeQuery(q);
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
