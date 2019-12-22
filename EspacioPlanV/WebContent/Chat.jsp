<%@page import="negocioImpl.PedidoNegImpl"%>
<%@page import="negocioImpl.MensajeNegImpl"%>
<%@page import="entidad.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="./css/chat-style.css">
	<link rel="stylesheet" href="./css/popup.css">
	<title>Chat</title>
	
	<script>function cerrarMensaje(mensaje){ document.getElementById(mensaje).style.display = "none";}</script>
	<script>
        function verificarPrecio()
        {
            var txtPrecio = document.getElementById("txtPrecio");

            if(txtPrecio.value == "")
            {
                alert("Debe ingresar un precio al pedido.");
                return false;
            }

            return true;
        }

        function verificarMensaje()
        {
            var txtMensaje = document.getElementById("txtMensaje");

            if(txtMensaje.value == "")
            {
                alert("El mensaje que quiere enviar está vacio.");
                return false;
            }
            
            return true;
        }
    </script>
	
	<%
		HttpSession mySession = request.getSession(false);
		Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
		
		ArrayList<MensajeChat> listaMensajes = new ArrayList<MensajeChat>();
		Pedido pedido = new Pedido();
		
		if(request.getParameter("idPedido") != null)
		{
			int idPedido = Integer.parseInt(request.getParameter("idPedido"));
			pedido = new PedidoNegImpl().ObtenerPedido(idPedido);
			listaMensajes = new MensajeNegImpl().ListarMensajes(idPedido);
		}
		
		if(request.getAttribute("resultadoModificacion") != null)
		{
			boolean resultado = (boolean) request.getAttribute("resultadoModificacion");
			
			if(resultado)
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Pedido modificado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	        	<p>Se han actualizado los datos del pedido.</p></div></div></div><%
			}
			else
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Error</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	        	<p>Ha ocurrido un error al intentar modificar. Intentalo mas tarde.</p></div></div></div><%
			}
		}
		
		if(request.getAttribute("resultadoEnviarMensaje") != null)
		{
			boolean resultado = (boolean) request.getAttribute("resultadoEnviarMensaje");
			
			if(resultado)
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Mensaje enviado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	        	<p>Se ha enviado el mensaje.</p></div></div></div><%
			}
			else
			{
				%><div id="popup" class="overlay"><div class="popupBody"><h2>Mensaje no enviado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	        	<p>Ha ocurrido un error al intentar enviar el mensaje. Intentalo nuevamente.</p></div></div></div><%
			}
		}
	
	%>
	
</head>
<body>

	 
    <div class="ventana-central">

        <div class="barra-superior">
            <div class="numero-pedido">Pedido N°<%=pedido.getId()%></div>
            
            <%if(usuario.getTipo().getId() == 1){%>
            
            	<form action="ServletPedido" method="POST" onsubmit="return verificarPrecio()">
            		<input type="hidden" name="idPedido" value="<%=pedido.getId()%>">
                	<div class="boton-guardar">
                    	<input type="submit" name="btnGuardar" value="Guardar">
                	</div>
                	<div class="estado-pedido">
                    	Estado: <select name="txtEstado" id="txtEstado">
                                	<%if(pedido.getEstado()==1){%><option value="1">En Revision</option><%}%>
                                	<option value="2">En Proceso</option>
                                	<option value="3">Listo</option>
                                	<option value="4">Cancelado</option>
                            	</select>
                 				<script>document.getElementById("txtEstado").value = <%=pedido.getEstado()%></script>
                	</div>
                	<div class="precio-pedido">
                    	Precio: <input type="number" value="<%=pedido.getPrecio()%>" name="txtPrecio" id="txtPrecio" style="width: 70px;">
                	</div>
            	</form>
            
            <%}%>
            
        </div>

        <hr class="linea-separadora">
        
        <div class="zona-mensajes">
			
			<%if(listaMensajes.size() != 0){%>
			
				<%for(int i=0; i<listaMensajes.size(); i++){%>
				
					<%if(listaMensajes.get(i).getUsuario().getId() == usuario.getId()){%>
					
						<div class="mensaje-derecho">
               				<div class="triangulo-derecho"></div>
                			<div class="rectangulo-mensaje-derecho">
                    			<div class="texto-mensaje-derecho">
                        			<label><%=listaMensajes.get(i).getMensaje()%></label>
                    			</div>
                			</div>
            			</div>
						
					<%}else{%>
					
						<div class="mensaje-izquierdo">
               				<div class="triangulo-izquierdo"></div>
                			<div class="rectangulo-mensaje-izquierdo">
                    			<div class="texto-mensaje-izquierdo">
                        			<label><%=listaMensajes.get(i).getMensaje()%></label>
                    			</div>
                			</div>
            			</div>
					
					<%}%>
										
				<%}%>
					
			<%}%>
		</div>
        <hr class="linea-separadora">
        
        <div class="barra-inferior">
            <form action="ServletPedido" method="POST" onsubmit="return verificarMensaje()">
            	<input type="hidden" name="idPedido" value="<%=pedido.getId()%>">
            	<input type="hidden" name="idUsuario" value="<%=usuario.getId()%>">
                <textarea name="txtMensaje" id="txtMensaje"></textarea>
                <input type="submit" name="btnEnviar" value="Enviar">
            </form>
        </div>
    </div>

</body>
</html>