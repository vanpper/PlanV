<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="./css/loginEstilos.css">
    <link rel="stylesheet" href="./css/popup.css">
	<script>function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}</script>
    <title>Bienvenido a PlanV</title>
    <jsp:include page="Includes.html"></jsp:include>
    
    <%
    	boolean error = false;
    
    	if(request.getAttribute("loginResultado") != null)
    	{
    		if((boolean) request.getAttribute("loginResultado") == false) error = true;
    	}
    	
    	if(request.getAttribute("registroResultado") != null){
    		
    		%><div id="popup" class="overlay"><div class="popupBody"><h2>Cuenta creada</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            <p>Tienes tu cuenta lista. Ya puedes ingresar.</p></div></div></div><%
    	}
    	
    	if(request.getAttribute("resultadoRecuperacion") != null)
    	{
    		%><div id="popup" class="overlay"><div class="popupBody"><h2>Recuperacion exitosa!</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            <p>Ya puedes volver a ingresar en tu cuenta con la contraseña que elegiste.</p></div></div></div><%
    	}
    %>
    
</head>
<body>
    <jsp:include page="barraNavegacion.jsp"></jsp:include>
    <jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Ingresar" /></jsp:include>
    

    <form action="ServletLogin?Param=loguearse" method="POST" class="formLogin" style="width: 40%;margin-left: 30%;overflow: hidden;margin-top: 40px; background-color: rgba(240,240,240); padding-bottom: 20px;">
        <br><br>
        <div class="left-align" style="text-align: left;float: left;width: 100%;"><label style="maegin-left:10px" for="">Email</label></div>
        <input type="email" name="txtEmail" id="txtEmail"> <br><br><br>
        <div class="left-align"><label for="">Contraseña</label></div>
        <input type="password" name="txtClave" id="txtClave"> <br><br><br><br>
        <%if(error == true){%><div class="left-align"><label><font color="red">Datos incorrectos</font></label></div><%}%>
        <button type="submit" name="btnIngresar" style="border-style: none;background-color: var(--second-color);">Ingresar</button><br><br>
        <a href="RecuperarContraseña.jsp" style="border-style: none;text-align: center;width: 90%" class="button">Olvide mi clave</a>
    </form>
    
	<script>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    </script>
</body>
</html>