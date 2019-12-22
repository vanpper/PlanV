<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PlanV</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="css/barraNavegacion.css">
<link rel="stylesheet" href="./css/popup.css">
<script>function cerrarMensaje(mensaje){ document.getElementById(mensaje).style.display = "none";}</script>


	<%
		if(request.getAttribute("resultadoRecuperacion") != null){
			%><div id="popup" class="overlay"><div class="popupBody"><h2>Error de restauracion</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
        	<p>Ha ocurrido un error al intentar restaurar la contraseña. Intentalo nuevamente mas tarde.</p></div></div></div><%
		}
	
		if(request.getAttribute("resultadoLogout") != null){
			%><div id="popup" class="overlay"><div class="popupBody"><h2>Adios</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
        	<p>Has salido de tu cuenta. Esperamos volver a verte pronto.</p></div></div></div><%
		}
		
		if(request.getAttribute("loginResultado") != null){
			%><div id="popup" class="overlay"><div class="popupBody"><h2>Bienvenido</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
        	<p>Has ingresado en tu cuenta con exito.</p></div></div></div><%
		}
	
	%>
	

</head>
<body>
	<jsp:include page="barraNavegacion.jsp"></jsp:include>
    <div class="barraCategorias">
        <button class="categoria" onclick="verProducto('Catalogo.jsp?idCategoria=1')">
            CUADERNOS
        </button>
        <button class="categoria" onclick="verProducto('Catalogo.jsp?idCategoria=2')">
            AGENDAS
        </button>
        <button class="categoria" onclick="verProducto('Catalogo.jsp?idCategoria=3')">
            CALENDARIOS
        </button>
        <button class="categoria" onclick="verProducto('Catalogo.jsp?idCategoria=4')">
            TARJETAS PERSONALES
        </button>
    </div>
    <div class="muroHome" style="background-image:url('./img/back2.jpg');overflow:hidden;background-size:400px;border-style: solid;border-width: 0px 0px 1px 0px;">
        <label>Plan V.</label>
    </div>
    <div class="muroCategorias">
        <div class="categoriaMenu" onclick="verProducto('Catalogo.jsp?idCategoria=1')" style="background-image:url('./img/cuadernos.jpg')">
            <div class="cubrirCategorias">
                Cuadernos
            </div>
        </div>
        <div class="categoriaMenu" onclick="verProducto('Catalogo.jsp?idCategoria=2')" style="background-image:url('./img/agendas.jpg')">
            <div class="cubrirCategorias">
                Agendas
            </div>
        </div>
        <div class="categoriaMenu" onclick="verProducto('Catalogo.jsp?idCategoria=3')" style="background-image:url('./img/calendarios.jpg')">
            <div class="cubrirCategorias">
                Calendarios
            </div>
        </div>
        <div class="categoriaMenu" onclick="verProducto('Catalogo.jsp?idCategoria=4')" style="background-image:url('./img/tarjetas.jpg')">
            <div class="cubrirCategorias">
                Tarjetas
            </div>
        </div>
    </div>
    <script>function verProducto(link){location.href=link;}</script>
</body>
</html>