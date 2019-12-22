<%@page import="datosImpl.ProductoDaoImpl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import= "entidad.*" %>
<%@ page import= "negocioImpl.*" %>
<%@ page import= "negocio.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="./css/verProducto.css">
	<jsp:include page="Includes.html"></jsp:include>
	<link rel="stylesheet" type="text/css" href="css/Catalogo.css">

	<!--SCRIPT QUE MUESTRA LA IMAGEN EN UN TAMAÑO MAS GRANDE-->
    <script>
        function agrandarImagen(id)
        {
            var imagenChica = document.getElementById(id);
            var imagenGrande = document.getElementById("imagenGrande");
            imagenGrande.src = imagenChica.src;
        }
    </script>

	<%
    	HttpSession mySession = request.getSession(false);
		Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
		
    	Producto producto = null;
    	
    	if(request.getParameter("idProducto") != null)
    	{
    		int idProducto = Integer.parseInt(request.getParameter("idProducto"));
    		producto = new ProductoNegImpl().ObtenerProducto(idProducto);
    	}
    %>
    
    <%if(producto == null){%><title>Producto no encontrado</title>
    <%}else{%><title><%=producto.getNombre()%></title><%}%>
    

</head>
<body class="body-ver-producto">

    <jsp:include page="barraNavegacion.jsp"></jsp:include>
    <%if(producto != null){%><jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="<%=producto.getTipo().getNombre()%>" /></jsp:include>
    <%}else{%><jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Producto no encontrado" /></jsp:include><%}%>
    
    <%if(producto != null && producto.getEstado() != false){%>
    	
    	<!--ESTE DIV ES TODO EL CUADRADO DONDE SE VE TODO-->
    	<div class="visor">
    
        <!--ESTE DIV MUESTRA TODAS LAS IMAGENES DEL PRODUCTO EN MINIATURAS-->
        <div class="imagenes-laterales-miniaturas">
			<div class="contenedor-imagen" onclick="agrandarImagen('imagen<%=producto.getListaImagenes().size()%>')">
	                <img src="./imgs/perfil/<%=producto.getUrlImagen()%>" alt="" class="imagen-producto-miniatura" id="imagen<%=producto.getListaImagenes().size()%>">
	          </div>	
			<%for(int i=0; i<producto.getListaImagenes().size(); i++)
			{%>
				<!--ESTE DIV CONTIENE UNA IMAGEN DEL PRODUCTO-->
	            <div class="contenedor-imagen" onclick="agrandarImagen('imagen<%=i%>')">
	                <img src="./imgs/detalle/<%=producto.getListaImagenes().get(i).getUrlImagen()%>" alt="" class="imagen-producto-miniatura" id="imagen<%=i%>">
	            </div>	
		  <%}%>

		</div>

        <!--DIV QUE MUESTRA EN GRANDE LA IMAGEN SELECCIONADA-->
        <div class="imagen-grande">
                <%if(producto.getListaImagenes().size() != 0){%><img src="./imgs/perfil/<%=producto.getUrlImagen()%>" alt="" class="imagen-producto-grande" id="imagenGrande">
                <%}else{%><img src="img/noimage.gif" alt="" class="imagen-producto-grande" id="imagenGrande"><%}%>
        </div>

        <!--ESTE DIV ES LA EL NOMBRE PRECIO DEL PRODUCTO Y BOTONES COMPRAR-->
        <div class="barra-derecha">
            <!--DIV QUE MUESTRA LOS DATOS DEL PRODUCTO-->
            <div class="visor-datos">
                <!--NOMBRE DEL PRODUCTO-->
                <div class="nombre-producto">
                    <label id="nombreProducto"><%=producto.getNombre()%></label>
                </div>
                <!--PRECIO VIEJO DEL PRODUCTO SI TUVIERE DESCUENTO-->
                <div class="precio-viejo">
                	<% if(producto.getDescuento() != 0) {%>$ <label id="precioProductoViejo"><%=producto.getPrecio()%></label><%}%>
                </div>
                <!--PRECIO DEL PRODUCTO-->
                <div class="precio-producto">
                    $ <label id="precioProducto"><%=producto.getPrecio() - (producto.getPrecio() * producto.getDescuento() / 100)%></label>
                </div>
                <!--DESCUENTO DEL PRODUCTO SI LO TUVIERE-->
                <div class="descuento-producto">
                <%if(producto.getDescuento() != 0) {%><label style="margin-left: 10px;" id="porcentajeDescuento"><%=producto.getDescuento()%></label>% off<%}%>
                </div>
            </div>
    
            <!--DIV QUE MUESTRA LAS OPCIONES PARA COMPRAR-->
            <div class="buy-section">
                <form action="ServletProducto" method="POST">
                	<input type="hidden" name="idProducto" value="<%=producto.getId()%>">
                    <!--CANTIDAD DEL PRODUCTO QUE SE VA A COMPRAR-->
                    <div class="cantidad-section">
                        Cantidad: <input type="number" value="1" min="1" max="<%=producto.getStock()%>" name="txtCantidad" id="txtCantidad">
                    </div>
                    <!--STOCK DISPONIBLE-->
                    <div class="cantidad-disponible">
                        Stock disponible: <label id="stockDisponible"><%=producto.getStock()%></label>  
                    </div>
                    <!--DIV BOTONES COMPRAR Y ADD CARRITO-->
                    <div class="buttons-section">
                    <%if(usuario != null){ %>
                        <input type="submit" name="btnAccion" value="Comprar" class="boton">
                        <input type="submit" name="btnAccion" value="Agregar al carrito" class="boton">
                    <%}%>
                    </div>
              	</form>
            </div>
        </div>
	
	        <!--ESTE DIV CONTIENE LA DESCRIPCION DEL PRODUCTO-->
	        <div class="descripcion-section">
	            <div class="descripcion-text">
	                <label id="txtDescripcion"><%=producto.getDescripcion()%></label>
	            </div>
	        </div>
	    </div>
    	
    <%}else{%>
    		<div class="vacio">
			<label id="lbvacio">Parece que la pagina no existe. <a href="Home.jsp">Ir a la pagina principal</a></label>
			</div>
    <%}%>
    
    <script>
    		document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    		document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    </script>
</body>
</html>