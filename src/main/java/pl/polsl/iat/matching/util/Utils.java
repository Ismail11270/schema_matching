package pl.polsl.iat.matching.util;

import pl.polsl.iat.matching.exception.RuntimeDatabaseException;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Utils {
    public static boolean unsafeResultSetNext(ResultSet rs){
        try {
            var bool = rs.next();
            return bool;
        } catch(SQLException e){
            throw new RuntimeDatabaseException(e);
        }
    }

}
