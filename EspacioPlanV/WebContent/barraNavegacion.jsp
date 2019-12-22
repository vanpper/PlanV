<%@ page import= "entidad.*" %>


	<%
		HttpSession mySession = request.getSession(false);
		Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
	%>


	<div class="barra">
	
	<%if(usuario != null){ %>
		<ul class="menu">
			<li>
				<a href="#" class="more"><span class="glyphicon glyphicon-option-vertical" aria-hidden="true"></span></a>
				<ul class="submenu">
					<li><a href="miCuenta.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>&nbsp;&nbsp;Mi cuenta</a></li>
				</ul>
			</li>
		</ul>
    <%} %>   
    <%if(usuario == null){%>
    	<a class="singIn" href="login.jsp">
        	<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span>&nbsp;&nbsp;<label>INGRESAR</label> 
       	</a>
    <%}else{%>
        <a class="singIn" href="ServletLogin?Param=desloguearse">
        	<span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>&nbsp;&nbsp;<label>SALIR</label> 
       	</a>
    <%}%>
    
    <%if(usuario == null){%>
    	<a class="singUp" href="Registrarse.jsp">
            <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>&nbsp;&nbsp;<label>REGISTRARSE</label>
        </a>
    <%}else{%>
        <a class="carrito" href="Carrito.jsp">
            <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>&nbsp;&nbsp;<label>CARRITO</label>
        </a>
        <a class="carrito" href="Pedidos.jsp">
            <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>&nbsp;&nbsp;<label>PEDIDOS</label>
        </a>
        <a class="carrito" href="Registro.jsp">
            <span class="glyphicon glyphicon-usd" aria-hidden="true"></span>&nbsp;&nbsp;<label>COMPRAS</label>
        </a>
        <a class="logo" href="miCuenta.jsp" style="float:right;margin-right:10px;    font-size: 1.4em;">
            Hola, <label><%=usuario.getNombre()%></label>
        </a>
    <%}%>
    	
        <a class="logo" href="Home.jsp">
            <label>PLAN V</label>
        </a>
    </div>