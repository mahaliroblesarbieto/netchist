<%-- 
    Document   : ingresarUsuario
    Created on : 11 dic. 2025, 9:47:39 a. m.
    Author     : GamingWorld
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>NetChis - Iniciar Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
</head>


<body class="bg-black text-white min-h-screen flex flex-col"> 
    
  
    <nav class="navbar bg-transparent absolute top-0 z-10">
        <div class="container mx-auto px-4 py-4">
            <a class="text-4xl font-extrabold text-red-600 tracking-tighter cursor-pointer" href="index.html">NETCHIS</a>
        </div>
    </nav>

   
    <div class="flex-grow flex items-center justify-center px-4 bg-[url('https://assets.nflxext.com/ffe/siteui/vlv3/93da5c27-be66-427c-8b72-5cb39d275279/94eb5ad7-10d8-4cca-bf45-520d31406664/PE-es-20240226-popsignuptwoweeks-perspective_alpha_website_large.jpg')] bg-cover bg-center">
      
        <div class="absolute inset-0 bg-black/60 z-0"></div>

        <div class="card bg-black/75 text-white w-full max-w-md p-8 md:p-12 z-10 shadow-2xl rounded-md border border-gray-800">
            
            <h2 class="text-3xl font-bold mb-8">Inicia sesión</h2>
            
           
            <% 
               String error = (String) request.getAttribute("error");
               if (error != null) { 
            %>
                <div class="alert alert-error mb-4 bg-orange-500/20 text-orange-500 border-none text-sm p-3 rounded">
                   <span><%= error %></span>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/UsuarioServlet" method="POST">
                <input type="hidden" name="accion" value="login">

                <div class="form-control mb-4">
                    <input type="email" name="correo" placeholder="Email o número de teléfono" class="input input-bordered bg-[#333] border-none text-white focus:bg-[#454545] focus:outline-none h-12 rounded" required />
                </div>

                <div class="form-control mb-8">
                    <input type="password" name="password" placeholder="Contraseña" class="input input-bordered bg-[#333] border-none text-white focus:bg-[#454545] focus:outline-none h-12 rounded" required />
                </div>

                <div class="form-control">
                    <button class="btn btn-block bg-red-600 hover:bg-red-700 text-white border-none font-bold text-lg h-12 rounded">Iniciar sesión</button>
                </div>
                
                <div class="flex justify-between items-center mt-2 text-xs text-gray-400">
                    <label class="cursor-pointer label p-0">
                        <span class="label-text text-gray-400 mr-2">Recuérdame</span> 
                        <input type="checkbox" class="checkbox checkbox-xs checkbox-primary rounded-sm" />
                    </label>
                    <a href="#" class="hover:underline">¿Necesitas ayuda?</a>
                </div>
            </form>

            <div class="mt-12 text-gray-500">
                <p>¿Primera vez en NetChis? <a href="<%= request.getContextPath() %>/registroUsuario.jsp" class="text-white hover:underline">Suscríbete ahora.</a></p>
                <p class="text-xs mt-4">Esta página está protegida por Google reCAPTCHA para comprobar que no eres un robot xd.</p>
            </div>
        </div>
    </div>

</body>
</html>

