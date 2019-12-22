<%@ page import="java.util.ArrayList"%>
<%@ page import= "entidad.*" %>
<%@ page import= "negocioImpl.*" %>
<%@ page import= "negocio.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mis compras</title>
<jsp:include page="Includes.html"></jsp:include>
<link rel="stylesheet" href="./css/registro-style.css">
<link rel="stylesheet" href="./css/popup.css">
<script>function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}</script>

	<%
		HttpSession mySession = request.getSession(false);
		Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
	
		ArrayList<Factura> listaFacturas = new ArrayList<Factura>();
		if(usuario != null) listaFacturas = new FacturaNegImpl().ListarTodas(usuario);
		
		if(request.getAttribute("resultadoCompraProducto") != null)
		{
			boolean resultado = (boolean)request.getAttribute("resultadoCompraProducto");
			
			if(resultado)
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Compra exitosa!</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            	<p>Se realizo la compra con exito. Ya puedes visualizar tu factura.</p></div></div></div><%
			}
			else
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Compra fallida</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            	<p>Ha ocurrido un error durante la compra. Vuelve a intentarlo.</p></div></div></div><%
			}
		}
		
		if(request.getAttribute("resultadoCompraCarrito") != null)
		{
			boolean resultado = (boolean)request.getAttribute("resultadoCompraCarrito");
			
			if(resultado)
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Carrito comprado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            	<p>Se realizo la compra del carrito con exito. Ya puedes visualizar tu factura.</p></div></div></div><%
			}
			else
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Carrito no comprado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            	<p>Ocurrio un error al intentar generar tu compra. Vuelve a intentarlo mas tarde.</p></div></div></div><%
			}
		}
		
		
	%>
</head>
<body>
    <jsp:include page="barraNavegacion.jsp"></jsp:include>
    <jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Compras"/></jsp:include>
    
    <%if(usuario != null){ %>
    	
    	<%if(listaFacturas.size() != 0){%>
    	
    		<div id="espacioRegistros" style="height:500px;transition:all 2s;overflow:hidden;margin-left:10px">
    		
    		
    		<div id="opciones" style="color:#fff;width:90%;float:left;margin-left:10px;height:30px;margin-top:20px;margin-botton:20px;overflow:hidden;transition:2s">	
				<diV style="float:left;height:30px;line-height:30px;margin-left:50px">
					N° Pedido: <input type="text" placeholder="ej. 1" style="background-color: rgba(0,0,0,0);height: 19px;border-style: solid;border-width: 0px 0px 1px 0px;border-color: rgb(100,100,100);padding-left: 5px;"></input>	
				</div>
				<div style="float:left;height:30px;line-height:30px;margin-left:50px">
					Fecha: <input type="date"  style="background-color: rgba(0,0,0,0);height: 19px;border-style: solid;border-width: 0px 0px 1px 0px;border-color: rgb(100,100,100);padding-left: 5px;"></input>	
				</div>
				<%if(usuario.getTipo().getId() == 1) {%>
				<div style="float:rigth;height:30px;line-height:30px;margin-left:50px">
					<a href="Reportes2.jsp" style="background-color: var(--second-color);padding: 5px;border-radius:5px;/* float: right; */color: black;margin-left: 50px;">Reportes</a>	
				</div>
			<% }%>	
			</div>
			<script>
			function filtrar(){
				
			}
			</script>
			<div style="float: left; width: 100%; height: 500px; overflow: scroll;">
			
				<%for (int i=0; i<listaFacturas.size(); i++){%>
					
					<div id="<%=i%>" onclick="estirar(<%=i%>,<%=listaFacturas.get(i).getDetalles().size()%>)" style="transition:height 1s;overflow:hidden;background-color: rgba(240,240,240,240);float:left;width:100%;height:40px;border-style:solid;border-width:0px 0px 1px 1px">
					<div style="float:left;width:100%;height:40px;"> 
					<div style="float:left;width:25%;heigth:40px;line-height:40px">
						<%=usuario.getNombre()%> <%=usuario.getApellido()%> 
					</div>
					<div style="float:left;width:25%;height:40px;line-height:40px">
						<%=listaFacturas.get(i).getFecha().toString()%>
					</div>
					<div style="float:left;width:25%;height:40px;line-height:40px">
						Factura: N°<%=listaFacturas.get(i).getId()%>
					</div>
					<input type="text" style="display:none" value="<%=listaFacturas.get(i).getId()%>">
					<div style="float:left;width:25%;height:40px;line-height:40px">
						Monto: <%=listaFacturas.get(i).getMonto()%>$
					</div>
					</div>
					
					<%for(int j=0; j<listaFacturas.get(i).getDetalles().size(); j++){%>
						
							<div style="float:left;width:100%;height:40px;background-color:var(--second-color)"> 
								<div style="float:left;width:25%;height:40px;line-height:40px">
									<%=listaFacturas.get(i).getDetalles().get(j).getProducto().getNombre()%>
								</div>
								<div style="float:left;width:25%;height:40px;line-height:40px">
									Precio(Unidad): <%=listaFacturas.get(i).getDetalles().get(j).getProducto().getPrecio()%>$
								</div>
								<div style="float:left;width:25%;height:40px;line-height:40px">
									<%=listaFacturas.get(i).getDetalles().get(j).getCantidad()%> unidades
								</div>
								<div style="float:left;width:25%;height:40px;line-height:40px">
									Total: <%=listaFacturas.get(i).getDetalles().get(j).getCantidad() * listaFacturas.get(i).getDetalles().get(j).getPrecioUnitario()%>$
								</div>
							</div>
						
					<%}%>
					
					</div>
				<%}%>
			
			</div>
		</div>
	
		<script>
		
		    document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
		    document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
		    document.getElementById("espacioRegistros").style.width=(document.documentElement.clientWidth-20)+"px";
		    
			function estirar(id,cant)
			{
				if(document.getElementById(id).style.height != 40+(40*cant)+"px")
				{
			    	document.getElementById(id).style.height = 40+(40*cant)+"px";
			    }else
			    {
			    	document.getElementById(id).style.height = "40px";
			    }
			}
			
		</script>
    	
    	<%}else{%>
    	
    		<div class="vacio">
			<label id="lbvacio">¿Todavia no has comprado nada?, miles de productos te esperan.</label>
			</div>
    	
    	<%}%>
    	
    	
    <%}else{%>
    	
    	<div class="vacio">
			<label id="lbvacio">Para ver tus compras, ingresa en tu cuenta</label>
		</div>
    	
    <%}%>
    
</body>
</html>