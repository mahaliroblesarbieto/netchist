<%@page import="java.util.List"%>
<%@page import="com.netchis.model.Pelicula"%>
<%@page import="com.netchis.model.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isELIgnored="false" %>

<%
    List<Categoria> listaCategorias = (List<Categoria>) request.getAttribute("listaCategorias");
    List<Pelicula> lista = (List<Pelicula>) request.getAttribute("lista");
    
    int categoriaSeleccionada = (request.getAttribute("categoriaSeleccionada") != null) ? 
                                (int) request.getAttribute("categoriaSeleccionada") : 0;
    
    if (listaCategorias == null) {
        listaCategorias = new ArrayList<>();
    }
    if (lista == null) {
        lista = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>NetChis - Catálogo</title>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@latest/dist/full.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            .text-netflix-red {
                color: #E50914;
            }
            .truncate-text {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
            }
        </style>
    </head>

    <body class="bg-black text-white min-h-screen"> 

        <nav class="navbar bg-black mb-8 border-b border-gray-800 shadow-xl">
            <div class="container mx-auto px-4 w-full flex justify-between">
                <a class="navbar-start text-3xl font-extrabold text-netflix-red" href="PeliculaServlet?accion=listar">NETCHIS</a>
                
                <div>
                    <ul class="menu menu-horizontal px-1 gap-2">
                        <li>
                            <a class="btn btn-ghost text-white hover:bg-gray-800" href="registroPelicula.jsp">
                                Registrar Película
                            </a>
                        </li>
                     
                        <li>
                            <a class="btn btn-ghost text-white hover:bg-gray-800" href="index.html">
                                Salir
                            </a>
                        </li>
                    </ul>
                    
                </div>
            </div>
        </nav>
    
        <div class="container mx-auto px-4">
            
            <h1 class="text-4xl font-extrabold text-white mb-6">Catálogo de Películas</h1>
            
            <%
               String msj = (String) session.getAttribute("msj");
               String tipo = (String) session.getAttribute("tipoMsj"); 
               String alertClass = ""; 
               
               if (msj != null) { 
                   if ("success".equals(tipo)) {
                       alertClass = "alert-success bg-gray-800 text-white border-green-500";
                   } else if ("danger".equals(tipo)) {
                       alertClass = "alert-error bg-gray-800 text-white border-red-500";
                   } else {
                       alertClass = "alert-info bg-gray-800 text-white border-blue-500";
                   }
            %>
                <div role="alert" class="alert <%= alertClass %> mb-6">
                    <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                    <span><%= msj %></span>
                </div>
            <% 
                   session.removeAttribute("msj");
                   session.removeAttribute("tipoMsj");
               } 
            %>


            <div class="mb-8 max-w-sm">
                <form action="PeliculaServlet" method="GET" class="flex gap-4 items-center">
                    <input type="hidden" name="accion" value="listar">
                    
                    <label class="label min-w-max"><span class="label-text text-white">Filtrar por Categoría:</span></label>
                    <select 
                        name="categoria_id" 
                        class="select select-bordered w-full bg-gray-700 text-white border-gray-600 focus:border-white"
                        onchange="this.form.submit()" 
                    >
                        <option value="0" <%= categoriaSeleccionada == 0 ? "selected" : "" %>>Todas las Categorías</option>
                        
                        <% 
                            if (!listaCategorias.isEmpty()) { 
                                for (Categoria cat : listaCategorias) {
                        %>
                                <option value="<%= cat.getId() %>" <%= categoriaSeleccionada == cat.getId() ? "selected" : "" %>>
                                   <%= cat.getNombre() %>
                                </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </form>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-8">

                <% 
                if (!lista.isEmpty()) {
                    for (Pelicula peliculaActual : lista) {
                %>
                      
                <div 
                      class="card card-compact shadow-xl border border-gray-800 
                      bg-gray-900 group cursor-default overflow-hidden 
                      transition-transform duration-300 hover:scale-105 relative">
              
                    <figure class="relative h-[300px] w-full overflow-hidden">
                        <% if (peliculaActual.getUrlPortada() != null && !peliculaActual.getUrlPortada().isEmpty()) {%>
                            <img src="<%= peliculaActual.getUrlPortada() %>" alt="<%= peliculaActual.getTitulo() %>" 
                                 class="w-full h-full object-cover transition-opacity duration-500 opacity-90 group-hover:opacity-60" />
                        <% } else { %>
                            <div class="w-full h-full flex flex-col items-center justify-center bg-gray-800 text-gray-500">
                                <span class="text-4xl">🎬</span>
                                <span class="text-xs mt-2">Sin Imagen</span>
                            </div>
                        <% }%>

                        <div class="absolute inset-0 bg-black/70 flex flex-col justify-end p-4 transition-opacity duration-300
                             opacity-0 group-hover:opacity-100">

                            <h2 class="text-white text-xl font-bold mb-2"><%= peliculaActual.getTitulo() %></h2>

                            <p class="text-sm text-gray-300 line-clamp-4">
                                 <%= peliculaActual.getDescripcion() %>
                            </p>
                        </div>

                        <div class="absolute top-2 right-2 badge bg-blue-600 text-white border-none font-bold shadow-lg z-10">
                            <%= peliculaActual.getAnio() %>
                        </div>
                    </figure>
              
                    <div class="card-body p-3 pt-2">
                       <h2 class="card-title text-white text-sm leading-tight mb-0 truncate-text" title="<%= peliculaActual.getTitulo() %>">
                           <%= peliculaActual.getTitulo() %>
                       </h2>
                       <p class="text-xs text-gray-400 line-clamp-1">Duración: <%= peliculaActual.getDuracion() %> min</p>

                        <div class="flex items-center justify-between mt-1 border-t border-gray-700 pt-2">
                            <span class="text-netflix-red font-extrabold text-lg">
                                S/.<%= String.format("%.2f", peliculaActual.getPrecioAlquiler()) %>
                            </span>
                        </div>
                    </div>
                </div>              
                
                <% } %>

                <% } else { %>

                <div class="col-span-full flex flex-col items-center justify-center p-12 bg-gray-900 rounded-lg border border-gray-800 border-dashed">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-gray-600 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z" />
                    </svg>
                    <h2 class="text-2xl font-bold text-gray-400 mb-2">¡No hay resultados!</h2>
                    <p class="text-gray-500">No se encontraron películas para la categoría seleccionada o el catálogo está vacío.</p>
                    <a href="PeliculaServlet?accion=listar" class="btn btn-sm btn-ghost mt-4 text-netflix-red hover:bg-gray-800">Mostrar todas las películas</a>
                </div>

                <% } %>
            </div>
        </div>
    </body>
</html>