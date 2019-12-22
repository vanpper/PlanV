<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="./css/RecuperarContraseña2-style.css">
	<link rel="stylesheet" href="./css/popup.css">
	<jsp:include page="Includes.html"></jsp:include>
	<script>function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}</script>
	<title>Ingresa tu codigo</title>
	
	<%	
		String codigoGenerado = "";
		if(request.getAttribute("codigoRecuperacion") != null) 
		{ 
			codigoGenerado = request.getAttribute("codigoRecuperacion").toString();
		}
		
		if(request.getAttribute("resultadoCompararCodigos") != null){%>
			<div id="popup" class="overlay"><div id="popupBody"><h2>Codigo incorrecto</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            <p>El codigo ingresado no es correcto. Revisa el codigo que te enviamos.</p></div></div></div>
		<%}
	%>
	
</head>
<body class="body-rc2">
    
    <jsp:include page="barraNavegacion.jsp"></jsp:include>
	<jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Ingresa tu codigo" /></jsp:include>
    
    <div class="ventana-central">
        <div class="mensaje1">
            <label>Hemos enviado un codigo de recuperacion a tu casilla de correo.</label>
        </div>
        <div class="mensaje2">
            <label>Ingresa el codigo aqui debajo</label>
        </div>
        <form action="ServletRecuperarContraseña?Param=compararCodigos" method="POST">
        	<input type="hidden" name="codigoGenerado" value="<%=codigoGenerado%>">
            <input type="text" name="txtCodigo" id="txtCodigo" placeholder="" maxlength="6">
            <input type="submit" name="btnEviar" value="Enviar" id="btnEnviar">
        </form>
	</div>

	<script>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("ventana-central").style.height=(document.documentElement.clientHeight-90)+"px";
    </script>

</body>
</html>