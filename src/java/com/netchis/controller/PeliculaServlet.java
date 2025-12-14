package com.netchis.controller;

import com.netchis.model.Pelicula;
import com.netchis.model.Categoria;
import java.io.IOException;
import dao.PeliculaDAO;
import dao.CategoriaDAO;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PeliculaServlet", urlPatterns = {"/PeliculaServlet"})
public class PeliculaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = request.getParameter("action");
        }

        if (accion == null) {
            accion = "listar";
        }

        PeliculaDAO peliculaDao = new PeliculaDAO();
        CategoriaDAO categoriaDao = new CategoriaDAO();

        switch (accion) {
            case "listar":
                
                int categoriaId = 0;
                String categoriaIdStr = request.getParameter("categoria_id");
                if (categoriaIdStr != null && !categoriaIdStr.isEmpty()) {
                    try {
                        categoriaId = Integer.parseInt(categoriaIdStr);
                    } catch (NumberFormatException e) {
                    }
                }
                
                List<Categoria> listaCategorias = categoriaDao.listarCategorias();
                
                List<Pelicula> lista;
                
                if (categoriaId > 0) {
                    lista = peliculaDao.listarPeliculasPorCategoria(categoriaId); 
                } else {
                    lista = peliculaDao.listarPeliculas();
                }

                request.setAttribute("lista", lista); 
                request.setAttribute("categoriaSeleccionada", categoriaId);
                request.setAttribute("listaCategorias", listaCategorias); 
                
                request.getRequestDispatcher("listaPeliculas.jsp").forward(request, response);
                break;
                
            case "detalle":
                response.sendRedirect("inicioUsuario.jsp");
                return;

            case "cargarParaActualizar":
                List<Pelicula> listaGestion = peliculaDao.listarPeliculas();
                request.setAttribute("listaPeliculas", listaGestion);
                request.getRequestDispatcher("actualizarPelicula.jsp").forward(request, response);
                break;

            case "eliminar":
                try {
                    String idParam = request.getParameter("id");
                    if (idParam != null && !idParam.trim().isEmpty()) {
                        int idEliminar = Integer.parseInt(idParam);
                        peliculaDao.eliminarPelicula(idEliminar);
                    }
                    response.sendRedirect("PeliculaServlet?accion=cargarParaActualizar");
                } catch (NumberFormatException e) {
                    // En caso de error en el formato del ID, redirigir a la lista de películas
                    response.sendRedirect("PeliculaServlet?accion=cargarParaActualizar");
                }
                break;
            
            case "editar":
                 try {
                    int idEditar = Integer.parseInt(request.getParameter("id"));
                    Pelicula peliculaAEditar = peliculaDao.obtenerPeliculaPorId(idEditar); 
                    request.setAttribute("pelicula", peliculaAEditar);
                    request.getRequestDispatcher("actualizarPelicula.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect("PeliculaServlet?accion=listar");
                    return;
                }
                break;

            default:
                request.getRequestDispatcher("registroPelicula.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion"); 
        if (accion == null) accion = request.getParameter("action");

        if ("actualizar".equals(accion)) {
            actualizarPelicula(request, response);
        } else {
            registrarPelicula(request, response);
        }
    }

    private void registrarPelicula(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String mensaje = "";
        String tipoMensaje = "";

        try {
            String titulo = request.getParameter("titulo");
            String descripcion = request.getParameter("descripcion");
            String duracionStr = request.getParameter("duracion");
            String anioStr = request.getParameter("anio");
            String precioStr = request.getParameter("precio");
            String url = request.getParameter("url_portada");
            String idCategoriaStr = request.getParameter("id_categoria");

            if (titulo == null || titulo.trim().isEmpty()) {
                throw new Exception("El título es obligatorio.");
            }
            if (idCategoriaStr == null || idCategoriaStr.isEmpty()) {
                throw new Exception("Debes seleccionar una categoría.");
            }

            int duracion = Integer.parseInt(duracionStr);
            int anio = Integer.parseInt(anioStr);
            double precio = Double.parseDouble(precioStr);
            int idCategoria = Integer.parseInt(idCategoriaStr);

            if (String.valueOf(anio).length() != 4) {
                throw new Exception("El año debe tener 4 dígitos.");
            }

            Pelicula nuevaPeli = new Pelicula();
            nuevaPeli.setTitulo(titulo);
            nuevaPeli.setDescripcion(descripcion);
            nuevaPeli.setDuracion(duracion);
            nuevaPeli.setAnio(anio); 
            nuevaPeli.setPrecioAlquiler(precio);
            nuevaPeli.setUrlPortada(url);
            nuevaPeli.setIdCategoria(idCategoria);

            PeliculaDAO dao = new PeliculaDAO();
            boolean exito = dao.registrarPelicula(nuevaPeli);

            if (exito) {
                mensaje = "¡Película registrada con éxito!";
                tipoMensaje = "success";
            } else {
                mensaje = "Error al guardar en la base de datos.";
                tipoMensaje = "danger";
            }

        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
        }

        request.setAttribute("msj", mensaje);
        request.setAttribute("tipoMsj", tipoMensaje);
        request.getRequestDispatcher("registroPelicula.jsp").forward(request, response);
    }

    private void actualizarPelicula(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        try {
            Pelicula p = new Pelicula();
            p.setId(Integer.parseInt(request.getParameter("id"))); 
            p.setTitulo(request.getParameter("titulo"));
            p.setDescripcion(request.getParameter("descripcion"));
            p.setDuracion(Integer.parseInt(request.getParameter("duracion")));
            p.setAnio(Integer.parseInt(request.getParameter("anio")));
            p.setPrecioAlquiler(Double.parseDouble(request.getParameter("precio")));
            p.setUrlPortada(request.getParameter("url_portada")); 

            String idCatStr = request.getParameter("id_categoria");
            p.setIdCategoria(Integer.parseInt(idCatStr)); 

            PeliculaDAO dao = new PeliculaDAO();
            dao.actualizarPelicula(p); 

            response.sendRedirect("PeliculaServlet?accion=cargarParaActualizar");

        } catch (Exception e) {
            response.sendRedirect("PeliculaServlet?accion=cargarParaActualizar");
        }
    }
}