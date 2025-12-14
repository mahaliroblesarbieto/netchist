package com.netchis.controller; // 1. Tu paquete de controladores

import com.netchis.model.Usuario;
import dao.UsuarioDAO; // 2. Importamos el DAO desde tu paquete 'dao'
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    UsuarioDAO dao = new UsuarioDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "registrar":
                    registrarUsuario(request, response);
                    break;
                case "login":
                    loginUsuario(request, response);
                    break;
                case "logout":
                    logoutUsuario(request, response);
                    break;
                default:
                    response.sendRedirect("inicioUsuario.jsp");
                    break;
            }
        } else {
            response.sendRedirect("inicioUsuario.jsp");
        }
    }

    private void loginUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");
        
        Usuario usuario = dao.validarLogin(correo, password);
        
        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);
            
            System.out.println("Login exitoso. Redirigiendo a Peliculas...");
            response.sendRedirect("PeliculaServlet?accion=listar");
            
        } else {
            request.setAttribute("error", "Correo o contraseña incorrectos. Inténtalo de nuevo.");
            request.getRequestDispatcher("inicioUsuario.jsp").forward(request, response);
        }
    }
    
    private void registrarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        if (nombre == null || nombre.isEmpty() || correo == null || correo.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("msj", "Todos los campos son obligatorios.");
            request.setAttribute("tipoMsj", "error");
            request.getRequestDispatcher("registroUsuario.jsp").forward(request, response);
            return;
        }

        if (dao.existeUsuario(correo)) {
            request.setAttribute("msj", "El correo " + correo + " ya está registrado.");
            request.setAttribute("tipoMsj", "error");
        } else {
            boolean exito = dao.registrarUsuario(nombre, correo, password);

            if (exito) {
                request.setAttribute("msj", "¡Registro exitoso! Ahora inicia sesión.");
                request.setAttribute("tipoMsj", "success");
            } else {
                request.setAttribute("msj", "Error al conectar con la base de datos.");
                request.setAttribute("tipoMsj", "error");
            }
        }
        request.getRequestDispatcher("registroUsuario.jsp").forward(request, response);
    }

    private void logoutUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("inicioUsuario.jsp"); 
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}