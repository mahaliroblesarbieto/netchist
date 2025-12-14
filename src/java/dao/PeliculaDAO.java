package dao;

import util.Conexion;
import com.netchis.model.Pelicula;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

public class PeliculaDAO {

    public boolean registrarPelicula(Pelicula p) {
        boolean registrado = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = Conexion.getConnection();

            String sql = "INSERT INTO peliculas (titulo, descripcion, anio, duracion, precio_alquiler, url_portada, categoria_id) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);

            ps.setString(1, p.getTitulo());
            ps.setString(2, p.getDescripcion());
            ps.setInt(3, p.getAnio());
            ps.setInt(4, p.getDuracion());
            ps.setDouble(5, p.getPrecioAlquiler());
            ps.setString(6, p.getUrlPortada());
            ps.setInt(7, p.getIdCategoria());

            if (ps.executeUpdate() > 0) {
                registrado = true;
            }

        } catch (Exception e) {
            System.out.println("Error al registrar película: " + e.getMessage());
            e.printStackTrace();
        } finally {
            cerrarRecursos(con, ps, null);
        }

        return registrado;
    }

    public List<Pelicula> listarPeliculas() {
        List<Pelicula> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = Conexion.getConnection();
            String sql = "SELECT * FROM peliculas ORDER BY id DESC";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Pelicula p = mapResultSetToPelicula(rs);
                lista.add(p);
            }

        } catch (Exception e) {
            System.out.println("Error al listar: " + e.getMessage());
        } finally {
            cerrarRecursos(con, ps, rs);
        }
        return lista;
    }
    
    public List<Pelicula> listarPeliculasPorCategoria(int idCategoria) {
        List<Pelicula> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = Conexion.getConnection();
            String sql = "SELECT * FROM peliculas WHERE categoria_id = ? ORDER BY id DESC";
            ps = con.prepareStatement(sql);
            ps.setInt(1, idCategoria); 
            rs = ps.executeQuery();

            while (rs.next()) {
                Pelicula p = mapResultSetToPelicula(rs);
                lista.add(p);
            }

        } catch (Exception e) {
            System.out.println("Error al listar películas por categoría: " + e.getMessage());
        } finally {
            cerrarRecursos(con, ps, rs);
        }
        return lista;
    }

    public boolean actualizarPelicula(Pelicula p) {
        boolean actualizado = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = Conexion.getConnection();
            String sql = "UPDATE peliculas SET titulo=?, descripcion=?, anio=?, duracion=?, precio_alquiler=?, url_portada=?, categoria_id=? WHERE id=?";

            ps = con.prepareStatement(sql);

            ps.setString(1, p.getTitulo());
            ps.setString(2, p.getDescripcion());
            ps.setInt(3, p.getAnio());
            ps.setInt(4, p.getDuracion());
            ps.setDouble(5, p.getPrecioAlquiler());
            ps.setString(6, p.getUrlPortada()); 
            ps.setInt(7, p.getIdCategoria());
            ps.setInt(8, p.getId());

            if (ps.executeUpdate() > 0) {
                actualizado = true;
            }

        } catch (Exception e) {
            System.out.println("Error al actualizar película: " + e.getMessage());
            e.printStackTrace();
        } finally {
            cerrarRecursos(con, ps, null);
        }

        return actualizado;
    }

    public boolean eliminarPelicula(int id) {
        boolean eliminado = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = Conexion.getConnection();
            
            // Primero verificar si la película existe
            String checkSql = "SELECT id FROM peliculas WHERE id = ?";
            ps = con.prepareStatement(checkSql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (!rs.next()) {
                System.out.println("No se encontró la película con ID: " + id);
                return false;
            }
            
            // Si existe, proceder con la eliminación
            ps.close();
            String deleteSql = "DELETE FROM peliculas WHERE id = ?";
            ps = con.prepareStatement(deleteSql);
            ps.setInt(1, id);

            int rowsAffected = ps.executeUpdate();
            System.out.println("Filas afectadas al eliminar: " + rowsAffected);
            
            if (rowsAffected > 0) {
                eliminado = true;
                System.out.println("Película eliminada exitosamente - ID: " + id);
            }

        } catch (Exception e) {
            System.out.println("Error al eliminar película con ID " + id + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            cerrarRecursos(con, ps, null);
        }
        return eliminado;
    }

    public Pelicula obtenerPeliculaPorId(int id) {
        Pelicula p = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = Conexion.getConnection();
            String sql = "SELECT * FROM peliculas WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                p = mapResultSetToPelicula(rs);
            }

        } catch (Exception e) {
            System.out.println("Error al obtener película por ID: " + e.getMessage());
        } finally {
            cerrarRecursos(con, ps, rs);
        }
        return p;
    }

    private Pelicula mapResultSetToPelicula(ResultSet rs) throws Exception {
        Pelicula p = new Pelicula();
        p.setId(rs.getInt("id"));
        p.setTitulo(rs.getString("titulo"));
        p.setDescripcion(rs.getString("descripcion"));
        p.setAnio(rs.getInt("anio"));
        p.setDuracion(rs.getInt("duracion"));
        p.setPrecioAlquiler(rs.getDouble("precio_alquiler"));
        p.setUrlPortada(rs.getString("url_portada"));
        p.setIdCategoria(rs.getInt("categoria_id"));
        return p;
    }

    private void cerrarRecursos(Connection con, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception e) {
        }
    }
}