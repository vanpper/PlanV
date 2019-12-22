<%@ page import= "entidad.*" %>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import= "negocioImpl.*" %>
<%@ page import= "negocio.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="./css/carritoStyle.css">
	<link rel="stylesheet" href="./css/popup.css">
    <title>Tu carrito</title>
	<jsp:include page="Includes.html"></jsp:include>
	
    <script>
        function calcularPrecioPorCantidad(numProducto)
        {
            var precioProducto = parseInt(document.getElementById("precioProducto" + numProducto).textContent);
            var cantidad = parseInt(document.getElementById("txtCantidad" + numProducto).value);
            var precioPorCantidad = document.getElementById("precioPorCantidad" + numProducto);
            
            precioPorCantidad.textContent = precioProducto * cantidad;

            calcularPrecioTotal();
        }

        function calcularPrecioTotal()
        {
            var cantidadProductos = document.getElementsByClassName("producto").length;
            var precioTotal = document.getElementById("txtTotal");
            var aux = 0;

            for(var i=0; i<cantidadProductos; i++)
            {
                aux += parseInt(document.getElementById("precioPorCantidad" + i).textContent);
            }
            
            precioTotal.textContent = aux;
        }
        
        function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}
    </script>
    
    <%
    	HttpSession mySession = request.getSession(false);
    	Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
    
    	CarritoNeg carritoNeg = new CarritoNegImpl();
    	ArrayList<ProductoCarrito> listaProductos = new ArrayList<ProductoCarrito>();
    	if(usuario != null) listaProductos = carritoNeg.ListarTodos(usuario);
    	
    	
    	
    	if(request.getAttribute("resultadoEliminarProductoCarrito") != null){
    		
    		boolean resultado = (boolean) request.getAttribute("resultadoEliminarProductoCarrito");
    		
    		if(resultado)
    		{
    			%><div id="popup" class="overlay"><div class="popupBody"><h2>Producto eliminado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            	<p>Se ha eliminado el producto de tu carrito.</p></div></div></div><%
    		}
    		else
    		{
    			%><div id="popup" class="overlay"><div class="popupBody"><h2>Producto no eliminado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            	<p>Ha ocurrido un error al intentar eliminar el producto. Intentalo nuevamente.</p></div></div></div><%
    		}
    	}
    %>

</head>
<body class="body-carrito">
    
    <jsp:include page="barraNavegacion.jsp"></jsp:include>
    <jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Carrito" /></jsp:include>
	<!--CONSULTA ANTES DE ELIMINAR-->
	<form action="ServletCarrito?Param=comprarTodos" method="POST">
	<div id="popupEliminar" class="overlay" style="display:none">
		<div class="popupBody" style="overflow: hidden">
			<div style="width:100%;float:left;overflow: hidden;height: 20px;"><div style="float:right"><a class="cerrar" href="#" onclick="cerrarMensaje('popupEliminar')">&times;</a></div></div>
			<div style="width:100%;float:left;text-align:center"><h2 style="margin: 0;font-size: 1.2em;" id="mensajeEliminar"></h2></div>
	        <div style="width:100%;float:left;text-align:center;margin-top: 10px;">
	        <input type="submit" class="btPop"  name="btnEliminar" value="SI" onclick="eliminarProducto()" style="border-style: none;cursor: pointer;margin-right:10px;width: 70px;">
	    	<input type="button" class="btPop"  value="NO" onclick="cerrarMensaje('popupEliminar')" style="border-style: none;cursor: pointer;margin-left:10px;width: 70px;"></div>
	    </div>
    </div>
    <input type="text" id="idEliminar" name="idProducto" style="display:none">
    </form>
    <script>
    	function eliminar(nombre,id){
    		document.getElementById("popupEliminar").style.display="initial";
    		document.getElementById("mensajeEliminar").innerText = 'Esta seguro que desea eliminar ' + nombre+' de su carrito ?';
    		document.getElementById("idEliminar").value = id;
    	}
    </script>

    <!--ESTE DIV ES LA VENTANA PRINCIPAL CENTRAL-->
    <div class="ventana-central">
        
       <%if(usuario != null){%>
       <%if(listaProductos.size() != 0){%>
       <form action="ServletCarrito?Param=comprarTodos" method="POST">
       <input type="text" name="total" style="display:none" value="<%=listaProductos.size()%>">
       <div>
	     	<%for(int i=0; i<listaProductos.size(); i++){%>
			
				<%if(listaProductos.get(i).getProducto().getEstado() != false){%>
					
					<!--ESTE DIV REPRESENTA UN PRODUCTO-->
	        		<div class="producto">
	        	
	            	<!--IMAGEN DEL PRODUCTO-->
	            	<div class="contenedor-imagen-producto">
	                	<%if(listaProductos.get(i).getProducto().getUrlImagen() != "" && listaProductos.get(i).getProducto().getUrlImagen() != null){%>
	                		<img src="<%=listaProductos.get(i).getProducto().getUrlImagen()%>" alt="" class="imagen-producto">
	            		<%}else{%><img src="img/noimage.gif" alt="" class="imagen-producto"><%}%>
	            	</div>
	            	
	            	<!--NOMBRE DEL PRODUCTO-->
	            	<div class="contenedor-nombre-producto">
	                	<a target="_blank" href="Producto.jsp?idProducto=<%=listaProductos.get(i).getProducto().getId()%>" class="nombre-producto" name="Producto<%=i%>" value="<%=i%>"><%=listaProductos.get(i).getProducto().getNombre()%></a>
	            	</div>
	            	
	            	<input type="text" name="id<%=i%>" style="display:none" value="<%=listaProductos.get(i).getProducto().getId()%>">
	            
	            	<!--FORM DEL BOTON ELIMINAR PRODUCTO-->
	            	<div class="contenedor-boton-eliminar">
	                
	                    <input type="hidden" name="idProducto" value="<%=listaProductos.get(i).getProducto().getId()%>">
	                    <button type="button" style="margin-top: 14px;background: none;border: 0;cursor: pointer;color: #13aff0;font-size: 15px;"  id="btnEliminar" onclick="eliminar('<%=listaProductos.get(i).getProducto().getNombre()%>',<%=listaProductos.get(i).getProducto().getId()%>)">Eliminar</button>
	                
	            	</div>
	            
	            	<!--ESTE DIV ES LA CAJA DE TEXTO PARA CAMBIAR LA CANTIDAD-->
	            	<div class="contenedor-cantidad">
	                	<input type="number" name="txtCantidad<%=i%>" id="txtCantidad<%=i%>" min="1" max="<%=listaProductos.get(i).getProducto().getStock()%>" value="<%=listaProductos.get(i).getCantidad()%>" onclick="calcularPrecioPorCantidad('<%=i%>')">
	                	<div class="contenedor-disponibles">Disponibles: <label id="txtDisponibles<%=i%>"><%=listaProductos.get(i).getProducto().getStock()%></label></div>
	            	</div>
	            	
	            	<!--ESTE DIV ES EL PRECIO DEL PRODUCTO-->
	            	<div class="contenedor-precio-producto">
	                	<label hidden id="precioProducto<%=i%>"><%=listaProductos.get(i).getProducto().getPrecio() - (listaProductos.get(i).getProducto().getPrecio() * listaProductos.get(i).getProducto().getDescuento() / 100)%></label> <!--PRECIO DEL PRODUCTO X UNIDAD-->
	                	$ <label id="precioPorCantidad<%=i%>"></label> <!--PRECIO DEL PRODUCTO POR LA CANTIDAD-->
	                	<script>calcularPrecioPorCantidad('<%=i%>');</script>
	            	</div>
	            	
	        		</div>
	        	
	        	<hr class="barra-divisoria">
				
				<%}%>
			
			<%}%>
		</div>
			
				
				
	        		
	        		<!--ESTE DIV ES EL BOTON DE COMPRAR QUE ESTA AL FINAL DE TODA LA LISTA Y MUESTRA EL TOTAL-->
	        		<div class="final-section">
	            		
	            		<div class="total-section">
	                		Total: $<label id="txtTotal"></label>
	                		<script>calcularPrecioTotal();</script>                
	            		</div>
	            		
	            		<div class="boton-section">
	                    	<input type="submit" value="Comprar todos" id="btnComprar" name="btnComprar">
	            		</div>
	            		<div class="boton-section">
	                    	<input type="submit" style="margin-right: 20px;" value="Guardar Cambios" id="btnComprar" name="btnGuardar">
	            		</div>
	        		</div>
	        		
	        	</form>
				
			<%}else{%>
			
				<div class="carrito-vacio">
					<label id="lbcarritovacio">Tu carrito está vacío</label>
				</div>
					
			<%}%>
        <%}else{%>
				<div class="carrito-vacio">
					<label id="lbcarritovacio">Para ver tu carrito, ingresa en tu cuenta</label>
				</div>
        <%}%>
        
    </div>
    
    <script>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    </script>

</body>
</html>