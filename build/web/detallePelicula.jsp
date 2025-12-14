

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="es" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Detalle: ${peli.titulo} | NETCHIS</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@latest/dist/full.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-black text-white min-h-screen">

    <c:if test="${peli != null}">
    
        <div class="hero min-h-[50vh] relative overflow-hidden" 
             style="background-image: url('${peli.urlPortada}'); background-size: cover; background-position: top center;">
            
            <div class="absolute inset-0 bg-black opacity-60"></div>
            
            <div class="hero-content text-center text-neutral-content z-10 p-8 w-full">
                
                <div class="max-w-4xl text-left">
                    <h1 class="text-6xl font-extrabold text-white mb-4">${peli.titulo}</h1>
                    
                    <div class="flex flex-wrap items-center space-x-4 mb-6">
                        <span class="badge badge-lg bg-red-600 border-red-600 text-white font-bold text-base">
                            ${peli.anio}
                        </span>
                        <span class="text-lg text-gray-300">
                            ${peli.duracion} min
                        </span>
                        <span class="badge badge-lg badge-success text-white font-bold text-lg">
                            S/. <c:out value="${peli.precioAlquiler}" />
                        </span>
                    </div>

                    <p class="text-xl mt-4 leading-relaxed text-gray-200">
                        ${peli.descripcion}
                    </p>
                    
                    <button class="btn btn-primary btn-lg mt-8 shadow-lg transition-all duration-200 hover:scale-105">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.26a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                        Alquilar ahora
                    </button>
                    
                </div>
            </div>
        </div>

        <div class="container mx-auto p-8 max-w-4xl">
            <h2 class="text-3xl font-bold mb-4">Detalles</h2>
            <div class="stats stats-vertical lg:stats-horizontal shadow bg-gray-900 border border-gray-700 w-full">
              
              <div class="stat">
                <div class="stat-title text-gray-400">Categoría ID</div>
                <div class="stat-value text-red-500">${peli.idCategoria}</div>
              </div>
              
              <div class="stat">
                <div class="stat-title text-gray-400">Calificación</div>
                <div class="stat-value text-yellow-500">4.5 / 5</div>
              </div>
              
              <div class="stat">
                <div class="stat-title text-gray-400">Disponible en</div>
                <div class="stat-value text-blue-500">HD</div>
              </div>
              
            </div>
            
            <a href="PeliculaServlet?accion=listar" class="btn btn-outline btn-sm mt-8">
                ← Volver al Catálogo
            </a>
        </div>
        
    </c:if>
    <c:if test="${peli == null}">
        <div class="hero min-h-screen bg-base-200">
            <div class="hero-content text-center">
                <div class="max-w-md">
                    <h1 class="text-5xl font-bold">Error 404</h1>
                    <p class="py-6">La película solicitada no se encontró. Vuelve al catálogo.</p>
                    <a href="PeliculaServlet?accion=listar" class="btn btn-primary">Ir al Catálogo</a>
                </div>
            </div>
        </div>
    </c:if>

</body>
</html>
