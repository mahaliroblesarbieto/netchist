<%-- 
    Document   : registroPelicula
    Created on : 26 nov. 2025, 9:53:35 p. m.
    Author     : GamingWorld
--%>
<%@page import="java.util.List"%>
<%@page import="com.netchis.model.Pelicula"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NetChis - Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>

<body class="bg-black text-white min-h-screen"> 
    
    <nav class="navbar bg-black mb-8 border-b border-gray-800 shadow-xl">
        <div class="container mx-auto px-4 flex justify-between items-center">
            
            <a class="text-4xl font-extrabold text-red-600 tracking-tighter cursor-pointer hover:text-red-500 transition-colors" href="#">
                NETCHIS
            </a>
                   
            <div>
                <ul class="menu menu-horizontal px-1 gap-2">
                    <li>
                        <a class="btn btn-ghost text-white hover:bg-gray-800" href="PeliculaServlet?accion=listar">
                            Ver Listado
                        </a>
                    </li>
                    
                    <li>
                        <a class="btn btn-ghost text-white hover:bg-gray-800" href="PeliculaServlet?accion=cargarParaActualizar">
                            Actualizar
                        </a>
                    </li>
                </ul>
            </div>

        </div>
    </nav>

    <div class="container mx-auto px-4 max-w-lg">
        <div class="flex justify-center">
            <div class="w-full">
                <% 
                   String msj = (String) request.getAttribute("msj");
                   String tipo = (String) request.getAttribute("tipoMsj"); 
                   String alertClass = ""; 
                   
                   if (msj != null) { 
                       if ("success".equals(tipo)) {
                           alertClass = "alert-success bg-gray-800 text-white border-green-500";
                       } else if ("danger".equals(tipo)) {
                           alertClass = "alert-error bg-gray-800 text-white border-netflix-red"; 
                       } else if ("warning".equals(tipo)) {
                           alertClass = "alert-warning bg-gray-800 text-white border-yellow-500";
                       } else {
                           alertClass = "alert-info bg-gray-800 text-white border-blue-500";
                       }
                %>
                    <div role="alert" class="alert <%= alertClass %> mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                        <span><%= msj %></span>
                    </div>
                <% } %>

                <div class="card bg-gray-800 shadow-2xl p-6 md:p-8">
                    <div class="card-body p-0">
                        <h2 class="text-3xl font-bold text-center mb-6 text-white">Registrar Nueva Película</h2>
                        
                        <form action="PeliculaServlet" method="POST" autocomplete="off">
                            <input type="hidden" name="accion" value="registrar">
                            
                            <div class="mb-4">
                                <label class="label"><span class="label-text text-white">Título *</span></label>
                                <input type="text" name="titulo" class="input input-bordered w-full bg-gray-700 text-white placeholder-gray-500 border-gray-600 focus:border-white" placeholder="Ej. Matrix" required>
                                <label class="label"><span class="label-text-alt text-gray-500">Entre 3 y 40 caracteres.</span></label>
                            </div>

                            <div class="mb-4">
                                <label class="label"><span class="label-text text-white">Descripción *</span></label>
                                <textarea name="descripcion" class="textarea textarea-bordered w-full bg-gray-700 text-white placeholder-gray-500 border-gray-600 focus:border-white" rows="2" placeholder="Sinopsis..." required></textarea>
                                <label class="label"><span class="label-text-alt text-gray-500">Entre 3 y 100 caracteres.</span></label>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div class="mb-4">
                                    <label class="label"><span class="label-text text-white">Duración (min) *</span></label>
                                    <input type="number" name="duracion" class="input input-bordered w-full bg-gray-700 text-white placeholder-gray-500 border-gray-600 focus:border-white" placeholder="120" required>
                                </div>
                                <div class="mb-4">
                                    <label class="label"><span class="label-text text-white">Año de estreno *</span></label>
                                    <input type="number" name="anio" class="input input-bordered w-full bg-gray-700 text-white placeholder-gray-500 border-gray-600 focus:border-white" placeholder="2024" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="label"><span class="label-text text-white">Precio Alquiler (S/.) *</span></label>
                                <input type="number" step="0.01" name="precio" class="input input-bordered w-full bg-gray-700 text-white placeholder-gray-500 border-gray-600 focus:border-white" placeholder="15.50" required>
                            </div>

                            <div class="mb-6">
                                <label class="label"><span class="label-text text-white">URL Portada</span></label>
                                <input type="text" name="url_portada" class="input input-bordered w-full bg-gray-700 text-white placeholder-gray-500 border-gray-600 focus:border-white" placeholder="http://...">
                            </div>
                            
                            <div class="mb-6">
                                <label class="label"><span class="label-text text-white">Categoría *</span></label>
                                <select name="id_categoria" class="select select-bordered w-full bg-gray-700 text-white border-gray-600 focus:border-white" required>
                                    <option disabled selected value="">Selecciona una categoría</option>
                                    <option value="1">Terror</option>
                                    <option value="2">Comedia</option>
                                    <option value="3">Acción</option>
                                    <option value="4">Drama</option>
                                    <option value="5">Ciencia Ficción</option>
                                </select>
                            </div>
                            
                            <div class="form-control mt-6">
                                <button type="submit" class="btn btn-lg bg-red-700 hover:bg-red-600 text-white border-0 font-bold">
                                    Registrar Película
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>