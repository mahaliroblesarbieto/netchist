package dao;

import util.Conexion;
import com.netchis.model.Categoria;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {
    
    public boolean registrarCategoria(String nombre) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean registrado = false;

        try {
            con = Conexion.getConnection();
            
            String sql = "INSERT INTO categorias (nombre) VALUES (?)";
            
            ps = con.prepareStatement(sql);
            
            ps.setString(1, nombre); 
            
            int filasAfectadas = ps.executeUpdate();
            
            if (filasAfectadas > 0) {
                registrado = true;
            }

        } catch (Exception e) {
            System.out.println("Error al insertar categoría: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {}
        }
        
        return registrado;
    }
    
    public List<Categoria> listarCategorias() {
        List<Categoria> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = Conexion.getConnection();
            String sql = "SELECT id, nombre FROM categorias ORDER BY nombre ASC"; 
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Categoria c = new Categoria();
                c.setId(rs.getInt("id"));
                c.setNombre(rs.getString("nombre"));
                
                lista.add(c);
            }

        } catch (Exception e) {
            System.out.println("Error al listar categorías: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {}
        }
        return lista;
    }
}