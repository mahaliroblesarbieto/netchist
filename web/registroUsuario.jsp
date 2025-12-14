<%-- 
    Document   : registroUsuario
    Created on : [Fecha Actual]
    Author     : Asistente
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NetChis - Registro de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>

<body class="bg-black text-white min-h-screen"> 
    
    <nav class="navbar bg-black mb-8 border-b border-gray-800 shadow-xl">
        <div class="container mx-auto px-4">
            <a class="text-4xl font-extrabold text-red-600 tracking-tighter cursor-pointer" href="index.html">NETCHIS</a>
            
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
                       } else if ("error".equals(tipo)) {
                           alertClass = "alert-error bg-gray-800 text-white border-red-600"; 
                       } else {
                           alertClass = "alert-info bg-gray-800 text-white border-blue-500";
                       }
                %>
                    <div role="alert" class="alert <%= alertClass %> mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                        <span><%= msj %></span>
                    </div>
                <% } %>

                <div class="card bg-gray-800 shadow-2xl p-6 md:p-8">
                    <div class="card-body p-0">
                        <h2 class="text-3xl font-bold text-center mb-6 text-white">Crear Cuenta</h2>
                        
                        <form action="UsuarioServlet" method="POST" autocomplete="off">
                            <input type="hidden" name="accion" value="registrar">
                            
                            <div class="mb-4">
                                <label class="label"><span class="label-text text-white">Nombre Completo *</span></label>
                                <input type="text" name="nombre" class="input input-bordered w-full bg-gray-700 text-white placeholder-gray-500 border-gray-600 focus:border-white" placeholder="Ej. Juan Pérez" required>
                            </div>

                            <div class="mb-4">
                                <label class="label"><span class="label-text text-white">Correo Electrónico *</span></label>
                                <input type="email" name="correo" class="input input-bordered w-full bg-gray-700 text-white placeholder-gray-500 border-gray-600 focus:border-white" placeholder="usuario@email.com" required>
                            </div>

                            <div class="mb-6">
                                <label class="label"><span class="label-text text-white">Contraseña *</span></label>
                                <input type="password" name="password" class="input input-bordered w-full bg-gray-700 text-white placeholder-gray-500 border-gray-600 focus:border-white" placeholder="******" required>
                            </div>
                            
                            <div class="form-control mt-6">
                                <button type="submit" class="btn btn-lg bg-red-700 hover:bg-red-800 text-white border-0 font-bold w-full">
                                    Registrarse
                                </button>
                            </div>
                            
                            <div class="text-center mt-4">
                                <p class="text-sm text-gray-400">¿Ya tienes cuenta? <a href="inicioUsuario.jsp" class="text-white hover:underline">Inicia sesión aquí</a></p>
                            </div>
                        </form>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
</body>
</html>