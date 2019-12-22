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
	<meta charset="ISO-8859-1">
	<title>Pedidos</title>
	<jsp:include page="Includes.html"></jsp:include>
	<link rel="stylesheet" type="text/css" href="css/pedidos.css">
	<link rel="stylesheet" href="./css/popup.css">
	<script>function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}</script>
	
	<%
		HttpSession mySession = request.getSession(false);
		Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
		
		ArrayList<Pedido> lista = new ArrayList<Pedido>();
		int estado = -1;
		int categoria = -1;
		if(usuario != null){
			if(request.getParameter("estado") != null)estado = Integer.parseInt(request.getParameter("estado"));
			if(request.getParameter("categoria") != null)categoria = Integer.parseInt(request.getParameter("categoria"));
			lista = new PedidoNegImpl().ListarPedidos(usuario,categoria,estado);
		}
		
		if(request.getAttribute("resultadoCancelar") != null)
		{
			boolean resultado = (boolean) request.getAttribute("resultadoCancelar");
			
			if(resultado)
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Cancelado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
           		<p>Se ha cancelado el pedido.</p></div></div></div><%
			}
			else
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Error</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
           		<p>Ha ocurrido un error al cancelar el pedido. Intentalo nuevamente mas tarde.</p></div></div></div><%
			}
		}
		
		if(request.getAttribute("resultadoAgregarPedido") != null)
		{
			boolean resultado = (boolean) request.getAttribute("resultadoAgregarPedido");
			
			if(resultado)
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Pedido agregado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
           		<p>Se ha agregado el pedido. En breve nos pondremos en contacto contigo. Podras visualizar el estado actual del producto en cualquier momento.</p></div></div></div><%
			}
			else
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Error</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
           		<p>Ha ocurrido un error al intentar agregar el nuevo pedido. Intentalo nuevamente.</p></div></div></div><%
			}
		}
		
		int filtroTipo = 0;
		
		if(request.getParameter("filtroTipo") != null)
		{
			filtroTipo = Integer.parseInt(request.getParameter("filtroTipo"));
		}
	%>

	
</head>
<body id="bodyPedidos" style="overflow:hidden">
	<!--CONSULTA ANTES DE ELIMINAR-->
	<form id="formCancelar" action="ServletPedido" method="POST">
	<div id="popupEliminar" class="overlay" style="display:none">
		<div class="popupBody" style="overflow: hidden">
			<div style="width:100%;float:left;overflow: hidden;height: 20px;"><div style="float:right"><a class="cerrar" href="#" onclick="cerrarMensaje('popupEliminar')">&times;</a></div></div>
			<div style="width:100%;float:left;text-align:center"><h2 style="margin: 0;font-size: 1.2em;" id="mensajeEliminar"></h2></div>
	        <div style="width:100%;float:left;text-align:center;margin-top: 10px;">
	        <input type="submit" class="btPop"  name="btnCancelar" value="SI" style="border-style: none;cursor: pointer;margin-right:10px;width: 70px;">
	    	<input type="button" class="btPop"  value="NO" onclick="cerrarMensaje('popupEliminar')" style="border-style: none;cursor: pointer;margin-left:10px;width: 70px;"></div>
	    </div>
    </div>
    <input type="text" id="idEliminar" name="idProducto" style="display:none">
    </form>
    <script>
    	function eliminar(id){
    		document.getElementById("popupEliminar").style.display="initial";
    		document.getElementById("mensajeEliminar").innerText = 'Esta seguro que desea cancelar el pedido N°' + id+'?';
    		document.getElementById("idEliminar").value = id;
    	}
    </script>
    
    
	<jsp:include page="barraNavegacion.jsp"></jsp:include>
	<jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Pedidos" /></jsp:include>

	<%if(usuario != null){%>
	
		<div id="espacioPedidos" style="transition:all 2s;overflow:hidden;">
				
				<div id="opciones" style="color:#fff;width:90%;float:left;margin-left:10px;height:30px;margin-top:10px;margin-botton:20px;overflow:hidden;transition:2s">
					<div style="float:left;height:30px;line-height:30px;margin-left:10px">
						Mostrar:
						<select id="selectTipo" onchange="filtrar()" style="background-color: rgba(0,0,0,0);border-color:rgb(100,100,100);border-width: 0px 0px 1px 0px;height:19px;color:rgb(100,100,100)">
							<option value="-1">Todos</option>
							<option value="1">Cuadernos</option>
							<option value="2">Agendas</option>
							<option value="3">Calendarios</option>
							<option value="4">Tarjetas</option>
						</select>
						<script>document.getElementById("selectTipo").value = <%=categoria%></script>
					</div>
					<div style="float:left;height:30px;line-height:30px;margin-left:20px">
						Estado:
						<select id="selectEstado" onchange="filtrar()" style="background-color: rgba(0,0,0,0);border-color:rgb(100,100,100);border-width: 0px 0px 1px 0px;height:19px;color:rgb(100,100,100)">
							<option value="-1">Todos</option>
							<option value="1">En Revision</option>
							<option value="2">En Proceso</option>
							<option value="3">Listo</option>
							<option value="4">Cancelado</option>
						</select>
						<script>
						function filtrar(){
							window.location= "Pedidos.jsp?categoria="+document.getElementById("selectTipo").value+"&estado="+document.getElementById("selectEstado").value;
						}
						
						document.getElementById("selectEstado").value = <%=estado%>;
						
						</script>
					</div>
				</div>
				
				
				<div id="cuadroPedido">
				
					<div id="agregar" class="cuadro elementoCorreo" style="background-color: #13aff0;font-weight: 100;float: left;font-size: 15px;LINE-HEIGHT: 40PX;width: 100%;height: 40px;color: rgb(80,80,80);transition: all 1s">
						<div onclick="agregarPedido()" style="float:left;height:40px;width:100%"><span id="gy" class="glyphicon glyphicon-plus" style="margin-left:10px" aria-hidden="true" ></span>&nbsp;<label id="titulo">AGREGAR UN NUEVO PEDIDO</label></div>
							<jsp:include page="./subHTML/nuevoPedido.html"></jsp:include>
					</div>
				<div id="correo">
				
					<%for(int i=0; i<lista.size(); i++) {%>
					
					
								
								<div id="correo<%=i%>"  class="elementoCorreo" style="overflow:hidden;transition: height 1s;">
								<div class="tipoCorreo" onclick="abrirChat('<%=lista.get(i).getId()%>')"><%=lista.get(i).getTipoProducto().getNombre()%></div>
								<%if(usuario.getTipo().getId() == 1){%><div class="userCorreo" ><%=lista.get(i).getUsuario().getNombre()%> <%=lista.get(i).getUsuario().getApellido()%></div><%}%>
								<div class="userCorreo" onclick="abrirChat('<%=lista.get(i).getId()%>')">Pedido N°<%=lista.get(i).getId()%></div>
								<div class="userCorreo" onclick="abrirChat('<%=lista.get(i).getId()%>')">Precio: $<%=lista.get(i).getPrecio()%></div>
								<div class="userCorreo" onclick="abrirChat('<%=lista.get(i).getId()%>')"><%=lista.get(i).getFecha().toString()%></div>
								<div style="float:right; margin-right:10px;" >
									<%if(lista.get(i).getEstado() == 1){%><div onclick="abrirChat('<%=lista.get(i).getId()%>')" class="tipoCorreo" style="background-color:yellow;">En revision</div><%}%>
									<%if(lista.get(i).getEstado() == 2){%><div onclick="abrirChat('<%=lista.get(i).getId()%>')" class="tipoCorreo">En proceso</div><%}%>
									<%if(lista.get(i).getEstado() == 3){%><div onclick="abrirChat('<%=lista.get(i).getId()%>')" class="tipoCorreo" style="background-color:green;">Listo</div><%}%>
									<%if(lista.get(i).getEstado() == 4){%><div onclick="abrirChat('<%=lista.get(i).getId()%>')" class="tipoCorreo" style="background-color:red;">Cancelado</div><%}%>
								<%if(lista.get(i).getEstado() == 1){%><div style="float: right;margin-top: 18px;margin-left: 10px;"><span onclick="eliminar(<%=lista.get(i).getId()%>)" class="glyphicon glyphicon-remove"></span></div><%}%>
								</div>
								</div>
					<%}%>
					</div>
				
					</div>
				</div>
				<jsp:include page="./subHTML/chatPedido.html"></jsp:include>
	
	<%}else{%>
	
		<div class="carrito-vacio">
			<label id="lbcarritovacio">Para ver tus pedidos, ingresa en tu cuenta</label>
		</div>
	
	<%}%>

			

<script>
	
	
	
	function abrirChat(idPedido)
	{
		window.open("Chat.jsp?idPedido=" + idPedido, "Chat", "width=800px, height=530px");
	}
	
	document.getElementById("nombre").style.height = (document.documentElement.clientHeight-30)+"px";
	document.getElementById("nombre").style.lineHeight = (document.documentElement.clientHeight-30)+"px";
	
	function cuadro(){
		document.getElementById("cuadroPedido").style.width=(document.documentElement.clientWidth-20)+"px";
		document.getElementById("opciones").style.width=(document.documentElement.clientWidth-20)+"px";
		document.getElementById("nuevoPedido").style.width=(document.documentElement.clientWidth-20)+"px";
		//document.getElementById("espacioChat").style.marginLeft =30+"px";
		//document.getElementById("espacioChat").style.width=((((document.documentElement.clientWidth-20)*70)/100)-60)+"px";
		//document.getElementById("espacioChat").style.marginTop =10+"px";
		//document.getElementById("espacioChat").style.height=(document.documentElement.clientHeight-20)+"px";
	}
	volverBandeja();
	setInterval(cuadro,50);
	function nuevoPedido(){
		document.getElementById("espacioPedidos").style.width="0px";
		document.getElementById("nuevoPedido").style.display="inherit";
		document.getElementById("chatPedido").style.display="none";
	}
	function volverBandeja(){
		document.getElementById("espacioPedidos").style.width="100%";
		document.getElementById("chatPedido").style.display="none";
	}
	function verMensaje(){
		document.getElementById("nuevoPedido").style.display="none";
		document.getElementById("espacioPedidos").style.width="0px";
		document.getElementById("chatPedido").style.display="inherit";
	}
	var  pedido=false;
	function agregarPedido(){
		if(!pedido){
			pedido=true;
			//document.getElementById("correo").style.display="none";
			document.getElementById("opciones").style.height="0px";
			document.getElementById("agregar").style.height="520px";
			document.getElementById("titulo").innerText="VOLVER A LA BANDEJA DE MENSAJES";
			document.getElementById("gy").setAttribute("class","glyphicon glyphicon-arrow-left");
		}else{
			pedido=false;
			//document.getElementById("correo").style.display="inherit";
			document.getElementById("opciones").style.height="30px";
			document.getElementById("agregar").style.height="40px";
			document.getElementById("titulo").innerText="AGREGAR UN NUEVO PEDIDO";
			document.getElementById("gy").setAttribute("class","glyphicon glyphicon-plus");
		}
	}
	var  mensaje=false;
	function ampliarMensaje(correo){
		if(!mensaje){
			mensaje=true;
			document.getElementById("opciones").style.height="0px";
			document.getElementById("agregar").style.height="0px";
			for(var i=0; i<5; i++){
				if(i==correo){
					document.getElementById("correo"+i).setAttribute("onclick","");
					document.getElementById("correo"+i).style.height="480px";
					document.getElementById("volver"+i).style.height="40px";
					document.getElementById("correo"+i).setAttribute("class","elementoCorreoSel");
					document.getElementById("mensaje"+i).style.display="none";
					document.getElementById("fecha"+i).style.display="none";
					document.getElementById("sinleer"+i).style.display="none";
				}else{
					document.getElementById("correo"+i).style.height="0px";
				}
			}
		}else{
			mensaje=false;
			document.getElementById("opciones").style.height="30px";
			document.getElementById("agregar").style.height="40px";
			for(var i=0; i<5; i++){
				if(i==correo){
					
					document.getElementById("correo"+i).setAttribute("onclick","ampliarMensaje("+i+")");
					document.getElementById("correo"+i).setAttribute("class","elementoCorreo");
					document.getElementById("correo"+i).style.height="50px";
					document.getElementById("volver"+i).style.height="0px";
					document.getElementById("mensaje"+i).style.display="inline-block";
					document.getElementById("fecha"+i).style.display="inherit";
					document.getElementById("sinleer"+i).style.display="inherit";
				}else{
					document.getElementById("correo"+i).style.height="50px";
				}
				
			}
		}
	}
	
	
</script>
</body>
</html>