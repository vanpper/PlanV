<%@ page import= "entidad.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
		<link rel="stylesheet" href="./css/Registrarse.css">
        <link rel="stylesheet" href="./css/popup.css">
        <script>function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}</script>
        <title>Cambia tu clave</title>
        <jsp:include page="Includes.html"></jsp:include>
        
        <script>
        function validarClaves()
        {
            var clave1 = document.getElementById("txtClaveNueva").value;
            var clave2 = document.getElementById("txtRepetirClave").value;

            if(clave1 != clave2)
            {
                alert("La nueva contraseña no coincide");
                return false;
            }
            
            if(clave1 == "" || clave2 == "")
            {
            	alert("Hay campos vacios");
                return false;
            }
            
            return true;
        }
    </script>
    
    <%
    	HttpSession mySession = request.getSession(false);
		Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
		
		if(request.getAttribute("errorClaveActual") != null)
		{
			%><div id="popup" class="overlay"><div id="popupBody"><h2>Clave actual incorrecta</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
       		<p>Tu clave actual ingresada no es correcta.</p></div></div></div><%
		}
    %>
</head>
<body class="ivan" style="overflow:hidden">
	<jsp:include page="barraNavegacion.jsp"></jsp:include>
	    <jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Cambiar Clave" /></jsp:include>
        
        <%if(usuario != null){%>
        	
        	<div id="cuadroTotal" class="centrar" style="width: 100%;overflow: hidden;vertical-align: middle;height: 100%;align-items: center;display:flex;">
            <form action="ServletCuenta?Param=cambiarClave" method="post" onsubmit="return validarClaves()">
                <label>Clave Actual</label> <br>
                <input type="password" name="txtClaveActual" id="txtClaveActual">
                <br><br>
                <label>Clave Nueva</label> <br>
                <input type="password" name="txtClaveNueva" id="txtClaveNueva">
                <br><br>
                <label>Repetir Clave Nueva</label> <br>
                <input type="password" name="txtRepetirClave" id="txtRepetirClave">
                <br><br>
                <div class="center"><button type="submit" name="btnModificar">Cambiar Clave</button></div>
            </form>
        </div>
        	
        <%}else{%>
        	<div class="vacio">
			<label id="lbvacio">Para cambiar tu clave, ingresa en tu cuenta.</label>
			</div>
      	<%}%>
        <script>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("cuadroTotal").style.height=(document.documentElement.clientHeight-90)+"px";
    	</script>
    </body>
</html>