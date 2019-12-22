<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="./css/RecuperarContraseña3-style.css">
	<jsp:include page="Includes.html"></jsp:include>
	<title>Ingresa tu nueva contraseña</title>

	<script>
        function compararClaves()
        {
            var clave1 = document.getElementById("txtClave1").value;
            var clave2 = document.getElementById("txtClave2").value;

            if(clave1 != clave2)
            {
                alert("Las contraseñas no coinciden");
                return false;
            }
            
            if(clave1 == "" || clave2 == "")
            {
                alert("Las claves no pueden quedar vacias");
                return false;
            }
            
            return true;
        }
    </script>
    
    <%
    	HttpSession mySession = request.getSession(false);
		String mail = mySession.getAttribute("mailRecuperacion").toString();	
    %>
    
</head>
<body class="body-rc3">

	<jsp:include page="barraNavegacion.jsp"></jsp:include>
	<jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Ingresa tu nueva contraseña" /></jsp:include>
    
    <div class="ventana-central">
        <form action="ServletRecuperarContraseña?Param=nuevaClave" method="POST" onsubmit="return compararClaves()">
        	<input type="hidden" name="email" value="<%=mail%>">
            <div class="d1"><label>Nueva contraseña:</label></div>
            <div class="d2"><input type="password" name="txtClave1" id="txtClave1"></div>
            <div class="d3"><label>Repite contraseña:</label></div>
            <div class="d4"><input type="password" name="txtClave2" id="txtClave2"></div>
            <div class="d5"><input type="submit" value="Guardar" name="btnGuardar"></div>
        </form>
    </div>

	<script>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("ventana-central").style.height=(document.documentElement.clientHeight-90)+"px";
    </script>
    
</body>
</html>