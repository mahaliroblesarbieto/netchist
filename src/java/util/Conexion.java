package util;

/**
 *
 * @author GamingWorld
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {


    private static final String HOST = "aws-1-sa-east-1.pooler.supabase.com"; 
    private static final String PORT = "5432";
    private static final String DATABASE = "postgres";
    
    private static final String USER = "postgres.lrzhenfdwwsqlvxnzqhm"; 
   
    private static final String PASSWORD = "patajordy1081"; 

    private static final String URL = "jdbc:postgresql://" + HOST + ":" + PORT + "/" + DATABASE + "?sslmode=require";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("org.postgresql.Driver");
            
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("¡Éxito! Conectado a Supabase (PostgreSQL)");
            
        } catch (ClassNotFoundException e) {
            System.out.println("Error: No encontré el Driver. ¿Agregaste el JAR de PostgreSQL a Libraries?");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Error de conexión SQL: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("Error general: " + e.getMessage());
        }
        return con;
    }
    
    public static void main(String[] args) {
        getConnection();
    }

    public Connection establecerConexion() {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    public void cerrarConexion() {
        throw new UnsupportedOperationException("Not supported yet."); 
    }
}
    

