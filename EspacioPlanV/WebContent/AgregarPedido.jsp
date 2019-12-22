<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Agrega Producto-PlanV</title>
<jsp:include page="Includes.html"></jsp:include>
<link rel="stylesheet" type="text/css" href="css/Catalogo.css">
</head>
<body style="overflow:hidden">
	<jsp:include page="barraNavegacion.jsp"></jsp:include>
	<jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Agregar Pedido" /></jsp:include>
		<jsp:include page="./subHTML/nuevoPedido.html"></jsp:include>
	<script>
	
	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
	
    
    </script>
</body>
</html>