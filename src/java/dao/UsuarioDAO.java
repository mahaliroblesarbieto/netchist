package dao;

import com.netchis.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.Conexion;

public class UsuarioDAO {
    
   Connection acceso;
    PreparedStatement ps;
    ResultSet rs;


    public Usuario validarLogin(String correo, String password) {
        String sql = "SELECT id_usuario, nombre, correo FROM usuarios WHERE correo = ? AND password = ?";
        Usuario u = null;
        
        try {
            acceso = Conexion.getConnection();
            ps = acceso.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                u = new Usuario();
                u.setId(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
            }
            
        } catch (SQLException e) {
            System.err.println("Error en login: " + e.toString());
        } finally {
            try {
                if(acceso != null) acceso.close();
                if(ps != null) ps.close();
                if(rs != null) rs.close();
            } catch (SQLException e) {}
        }
        return u; 
    }
    
     public boolean existeUsuario(String correo) {
        String sql = "SELECT id_usuario FROM usuarios WHERE correo = ?";
        try {
            acceso = Conexion.getConnection(); 
            ps = acceso.prepareStatement(sql);
            ps.setString(1, correo);
            rs = ps.executeQuery();
            if (rs.next()) return true;
        } catch (SQLException e) {
            System.err.println("Error al validar: " + e.toString());
        }
        return false; 
    }

    public boolean registrarUsuario(String nombre, String correo, String password) {
        String sql = "INSERT INTO usuarios (nombre, correo, password) VALUES (?, ?, ?)";
        try {
            acceso = Conexion.getConnection();
            ps = acceso.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, correo);
            ps.setString(3, password); 
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al registrar: " + e.toString());
            return false;
        }
    }
}