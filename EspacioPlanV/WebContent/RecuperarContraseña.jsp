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
        <title>Recupera tu cuenta</title>
        <jsp:include page="Includes.html"></jsp:include>
        
        <script>
        
			function validarCampos() {
                
				var txtMail = document.getElementById("txtMail").value;
				
				if(txtMail == "")
                {
                    alert("Debe ingresar un email");
                    return false;
                }
				
                return true;
            }
            
			function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}
        
		</script>
        
            <%if(request.getAttribute("resultadoEnviarCodigo") != null){%>
            	<div id="popup" class="overlay"><div class="popupBody"><h2>Error de envio</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
                <p>Ha ocurrido un error al intentar enviar el codigo de recuperacion.</p></div></div></div>
            <%}%>

        
</head>
<body class="ivan" style="overflow:hidden">

	<jsp:include page="barraNavegacion.jsp"></jsp:include>
	<jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Recuperar Clave" /></jsp:include>
        
        <div id="cuadroTotal" class="centrar" style="width: 100%;overflow: hidden;vertical-align: middle;height: 100%;align-items: center;display:flex;">
            <form action="ServletRecuperarContraseña?Param=enviarCodigo" method="POST" onsubmit="return validarCampos()" autocomplete="off">
                <label for="txtNombre">Mail</label> <br>
                <input type="email" name="txtMail" id="txtMail"><br><br>
                <div class="center"><button type="submit" name="recuperar">Recuperar Clave</button></div>
            </form>
        </div>
        
   	<script>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("cuadroTotal").style.height=(document.documentElement.clientHeight-90)+"px";
    </script>
    </body>
</html>