<%-- 
    Document   : actualizarPelicula
    Created on : 14 dic. 2025, 10:32:19 a. m.
    Author     : GamingWorld
--%>

<%@page import="java.util.List"%>
<%@page import="com.netchis.model.Pelicula"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="es" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>NETCHIS - Gestionar</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #0f1218; } 
        .bg-netchis-card { background-color: #1f2937; }
        .text-netchis-red { color: #dc2626; }
    </style>
</head>
<body class="min-h-screen p-8 text-gray-200">

    <div class="flex justify-between items-center mb-8">
        <div>
             <h1 class="text-4xl font-bold text-netchis-red tracking-tighter">NETCHIS</h1>
             <h2 class="text-xl font-semibold text-white mt-1">Panel de Administración</h2>
        </div>
        <a href="PeliculaServlet?accion=listar" class="btn btn-outline text-white hover:bg-white hover:text-black">
            Ver Listado
        </a>
    </div>

    <div class="overflow-x-auto bg-netchis-card rounded-lg shadow-xl border border-gray-800">
        <table class="table w-full">
            <thead class="bg-black text-gray-400 font-bold text-sm uppercase">
                <tr>
                    <th>ID</th>
                    <th>Título / Descripción</th>
                    <th>Año</th>
                    <th>Duración</th>
                    <th>Precio</th>
                    <th>ID Cat.</th>
                    <th class="text-center">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // RECUPERAMOS LA LISTA EN JAVA PURO
                    List<Pelicula> lista = (List<Pelicula>) request.getAttribute("listaPeliculas");
                    
                    if (lista != null && !lista.isEmpty()) {
                        for (Pelicula p : lista) {
                %>
                <tr class="hover:bg-gray-800 border-b border-gray-700">
                    <td class="font-bold text-netchis-red">#<%= p.getId() %></td>
                    <td>
                        <div class="font-bold text-white text-lg"><%= p.getTitulo() %></div>
                        <div class="text-xs opacity-70 truncate w-64"><%= p.getDescripcion() %></div>
                    </td>
                    <td><%= p.getAnio() %></td>
                    <td><%= p.getDuracion() %> min</td>
                    <td class="text-green-400 font-bold">S/. <%= p.getPrecioAlquiler() %></td>
                    <td><span class="badge badge-neutral"><%= p.getIdCategoria() %></span></td>
                    <td class="flex justify-center gap-2 mt-2">
                        <button 
                            data-id="<%= p.getId() %>"
                            data-titulo="<%= p.getTitulo().replace("'", "&#39;").replace("\"", "&quot;") %>"
                            data-desc="<%= p.getDescripcion() != null ? p.getDescripcion().replace("'", "&#39;").replace("\"", "&quot;") : "" %>"
                            data-anio="<%= p.getAnio() %>"
                            data-duracion="<%= p.getDuracion() %>"
                            data-precio="<%= p.getPrecioAlquiler() %>"
                            data-categoria="<%= p.getIdCategoria() %>"
                            data-url="<%= p.getUrlPortada() != null ? p.getUrlPortada().replace("'", "&#39;").replace("\"", "&quot;") : "" %>"
                            class="btn-editar btn btn-sm btn-info text-white">
                            Editar
                        </button>
                        
                        <a 
                            href="<%= request.getContextPath() %>/PeliculaServlet?accion=eliminar&id=<%= p.getId() %>"
                            class="btn btn-sm btn-error text-white"
                            onclick="return confirm('¿Estás seguro de eliminar esta película?');">
                            Eliminar
                        </a>
                    </td>
                </tr>
                <% 
                        } // Cierre del for
                    } else { 
                %>
                    <tr><td colspan="7" class="text-center p-10 text-xl">No hay películas cargadas.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <dialog id="modal_editar" class="modal modal-bottom sm:modal-middle">
      <div class="modal-box bg-[#1a1f26] border border-gray-600 text-white">
        <h3 class="font-bold text-2xl text-netchis-red mb-4">Editar Película</h3>
        
        <form action="PeliculaServlet" method="POST" class="space-y-3">
            <input type="hidden" name="accion" value="actualizar">
            <input type="hidden" id="edit_id" name="id">

            <div>
                <label class="label"><span class="label-text text-gray-400">Título</span></label>
                <input type="text" id="edit_titulo" name="titulo" class="input input-bordered w-full bg-gray-900" required />
            </div>

            <div>
                <label class="label"><span class="label-text text-gray-400">Descripción</span></label>
                <textarea id="edit_descripcion" name="descripcion" class="textarea textarea-bordered w-full bg-gray-900" required></textarea>
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="label"><span class="label-text text-gray-400">Año</span></label>
                    <input type="number" id="edit_anio" name="anio" class="input input-bordered w-full bg-gray-900" required />
                </div>
                <div>
                    <label class="label"><span class="label-text text-gray-400">Duración (min)</span></label>
                    <input type="number" id="edit_duracion" name="duracion" class="input input-bordered w-full bg-gray-900" required />
                </div>
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="label"><span class="label-text text-gray-400">Precio (S/.)</span></label>
                    <input type="number" step="0.1" id="edit_precio" name="precio" class="input input-bordered w-full bg-gray-900" required />
                </div>
                <div>
                    <label class="label"><span class="label-text text-gray-400">ID Categoría</span></label>
                    <input type="number" id="edit_categoria" name="id_categoria" class="input input-bordered w-full bg-gray-900" required />
                </div>
            </div>
            
            <div>
                <label class="label"><span class="label-text text-gray-400">URL Portada</span></label>
                <input type="text" id="edit_url" name="url_portada" class="input input-bordered w-full bg-gray-900" />
            </div>

            <div class="modal-action">
              <button type="button" class="btn btn-ghost" onclick="modal_editar.close();">Cancelar</button>
              <button type="submit" class="btn btn-error text-white">Guardar Cambios</button>
            </div>
        </form>
      </div>
      <form method="dialog" class="modal-backdrop"><button>close</button></form>
    </dialog>

    <script>
        const modal_editar = document.getElementById('modal_editar');
        
        
        document.addEventListener('click', function(e) {
            
            if (e.target.classList.contains('btn-editar')) {
                const btn = e.target;
                document.getElementById('edit_id').value = btn.dataset.id;
                document.getElementById('edit_titulo').value = btn.dataset.titulo;
                document.getElementById('edit_descripcion').value = btn.dataset.desc || '';
                document.getElementById('edit_anio').value = btn.dataset.anio;
                document.getElementById('edit_duracion').value = btn.dataset.duracion;
                document.getElementById('edit_precio').value = btn.dataset.precio;
                document.getElementById('edit_categoria').value = btn.dataset.categoria;
                document.getElementById('edit_url').value = btn.dataset.url || '';
                modal_editar.showModal();
            }
            
           
        });
        
        
        modal_editar.addEventListener('click', (e) => {
            if (e.target === modal_editar) {
                modal_editar.close();
            }
        });
    </script>
</body>
</html>