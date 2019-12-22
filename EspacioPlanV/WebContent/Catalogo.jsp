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
	<title>Catalogo-PlanV</title>
	<jsp:include page="Includes.html"></jsp:include>
	<link rel="stylesheet" type="text/css" href="css/Catalogo.css">
	<link rel="stylesheet" href="./css/popup.css">
	<script>function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}</script>
	<%	
		HttpSession mySession = request.getSession(false);
		Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
		
		ArrayList<Producto> listaProductos = new ArrayList<Producto>();
		TipoProducto tipo = null;
	
		if(request.getParameter("idCategoria") != null) tipo = new TipoProductoNegImpl().ObtenerTipoProducto(Integer.parseInt(request.getParameter("idCategoria")));
		int totalMax = 0;
		int cantXPage = 1;
		if(tipo != null){
			
			int sort = 1;
			if(request.getParameter("sort") != null) sort = Integer.parseInt(request.getParameter("sort"));
			int min = 1;
			if(request.getParameter("min") != null) min = Integer.parseInt(request.getParameter("min"));
			int max = -1;
			if(request.getParameter("max") != null) max = Integer.parseInt(request.getParameter("max"));
			String nom = "";
			if(request.getParameter("nomb") != null) nom = request.getParameter("nomb");
			int pagina = 1;
			if(request.getParameter("page") != null) pagina = Integer.parseInt(request.getParameter("page"));			
			listaProductos = new ProductoNegImpl().ListarTodosPorCategoria(Integer.parseInt(request.getParameter("idCategoria")),sort,min,max,nom);
			totalMax = listaProductos.size();
			int last = (pagina)*cantXPage;
			if(last >= totalMax) last = totalMax;
			listaProductos = new ArrayList<Producto>(listaProductos.subList((pagina-1)*cantXPage,last));
			
			if(request.getAttribute("resultadoEliminacion") != null)
			{
				boolean resultado = (boolean) request.getAttribute("resultadoEliminacion");
				
				if(resultado)
				{
					%><div id="popup" class="overlay"><div class="popupBody">
					<h2>Producto eliminado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	           		<p>Se ha eliminado el producto.</p></div></div></div><%
				}
				else
				{
					%><div id="popup" class="overlay"><div class="popupBody"><h2>Producto no eliminado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	           		<p>Ha ocurrido un error al eliminar el producto. Intentelo nuevamente.</p></div></div></div><%
				}
			}
			
			if(request.getAttribute("resultadoAgregarACarrito") != null)
	    	{
	    		boolean resultado = (boolean)request.getAttribute("resultadoAgregarACarrito");
	    		
	    		if(resultado)
	    		{
	    			%><div id="popup" class="overlay"><div class="popupBody"><h2>Producto agregado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	           		<p>Se agrego el producto a tu carrito.</p></div></div></div><%
	    		}
	    		else
	    		{
	    			%><div id="popup" class="overlay"><div class="popupBody"><h2>Producto no agregado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	            	<p>No se ha agregado el producto. Tal vez ya lo tienes en tu carrito.</p></div></div></div><%
	    		}
	    	}
			
			if(request.getAttribute("resultadoAgregar") != null)
			{
				boolean resultado = (boolean) request.getAttribute("resultadoAgregar");
				
				if(resultado)
				{
					%><div id="popup" class="overlay"><div class="popupBody"><h2>Producto agregado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	           		<p>Se ha agregado un nuevo producto.</p></div></div></div><%
				}
				else
				{
					%><div id="popup" class="overlay"><div class="popupBody"><h2>Producto no agregado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	           		<p>Ha ocurrido un error al agregar el producto. Intentelo nuevamente.</p></div></div></div><%
				}
			}
			
			if(request.getAttribute("resultadoModificar") != null)
			{
				boolean resultado = (boolean) request.getAttribute("resultadoModificar");
				
				if(resultado)
				{
					%><div id="popup" class="overlay"><div class="popupBody"><h2>Producto modificado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	           		<p>La moficacion se ha registrado con exito.</p></div></div></div><%
				}
				else
				{
					%><div id="popup" class="overlay"><div class="popupBody"><h2>Producto no modificado</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
	           		<p>Ha ocurrido un error al modificar el producto. Intentelo nuevamente.</p></div></div></div><%
				}
			}
		}
	%>
	
</head>
<body style="overflow:hidden">
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
    <script>function verProducto(link){location.href=link;}</script>
    <%if(tipo == null){%>
		<div id="error" style="background-color:#171717;text-align:center;font-size:2em">
			CATEGORIA INEXISTENTE
		</div>
		<script>
			document.getElementById("error").style.height=(document.documentElement.clientHeight-80)+"px";
			document.getElementById("error").style.lineHeight=(document.documentElement.clientHeight-80)+"px";
		</script>
	<%}else{%>
	<!--CONSULTA ANTES DE ELIMINAR-->
	<form action="ServletCatalogo" method="POST">
	<div id="popupEliminar" class="overlay" style="display:none">
		<div class="popupBody" style="overflow: hidden">
			<div style="width:100%;float:left;overflow: hidden;height: 20px;"><div style="float:right"><a class="cerrar" href="#" onclick="cerrarMensaje('popupEliminar')">&times;</a></div></div>
			<div style="width:100%;float:left;text-align:center"><h2 style="margin: 0;font-size: 1.2em;" id="mensajeEliminar"></h2></div>
	        <div style="width:100%;float:left;text-align:center;margin-top: 10px;">
	        <input type="submit" class="btPop"  name="btEliminar" value="SI" onclick="eliminarProducto()" style="border-style: none;cursor: pointer;margin-right:10px;width: 70px;">
	    	<input type="button" class="btPop"  value="NO" onclick="cerrarMensaje('popupEliminar')" style="border-style: none;cursor: pointer;margin-left:10px;width: 70px;"></div>
	    </div>
    </div>
    <input type="text" id="idEliminar" name="idProducto" style="display:none">
    <input type="text" id="idCategoria" name="idCategoria" style="display:none">
    </form>
    <script>
    	function eliminar(nombre,id){
    		document.getElementById("popupEliminar").style.display="initial";
    		document.getElementById("mensajeEliminar").innerText = 'Esta seguro que desea eliminar ' + nombre;
    		document.getElementById("idEliminar").value = id;
    		document.getElementById("idCategoria").value = <%=request.getParameter("idCategoria")%>;
    	}
    </script>
    <!--CONSULTA CANTIDAD CARRITO-->
    <form action="ServletCatalogo" method="POST">
	<div id="popupCantidad" class="overlay" style="display:none">
		<div class="popupBody" style="overflow: hidden;">
			<div style="width:100%;float:left;overflow: hidden;height: 20px;"><div style="float:right"><a class="cerrar" href="#" onclick="cerrarMensaje('popupCantidad')">&times;</a></div></div>
			<div style="width:300px;float:left;height:300px;">
				<div id="imgCarrito" style="width:280px;height:280px;margin-top:10px;margin-left:5px;float:left;background-position:center;background-size:cover">
				</div>
			</div>
			<div style="width:300px;float:left;height:300px;">
				<div style="width:100%;height:100px;float:left;overflow: hidden;background-color: rgb(240,240,240);font-size: 1.4em;margin-top: 40px;">
					<label id="nombreCarrito" style="margin: 10px;"></label>
				</div>
				<div style="width:100%;height:50px;float:left;line-height: 60px;text-align: center;">
					<label>Cantidad:</label><input style="line-height: 20px;" value="1" min="1" type="number" id="cantidadCarrito" name="cantidad">
				</div>
				<div style="width:100%;height: 60px;float:left;line-height: 60px;text-align: center;">
					<input  class="btPop"  type="submit" style="border-style: none;width: 100%;line-height: 25px;" value="AGREGAR AL CARRITO" name="btAgregar">
				</div>
			</div>
	    </div>
    </div>
    <input type="text" id="idAgregar" name="idProducto" style="display:none">
    <input type="text" id="idCategoriaAgregar" name="idCategoria" style="display:none">
    </form>
    <script>
    	function establecerCantidad(nombre,id,url, max){
    		document.getElementById("popupCantidad").style.display="initial";
    		document.getElementById("imgCarrito").style.backgroundImage='url('+url+')';
    		document.getElementById("nombreCarrito").innerText=nombre;
    		document.getElementById("idAgregar").value = id;
    		document.getElementById("idCategoriaAgregar").value = <%=request.getParameter("idCategoria")%>;
    		document.getElementById("cantidadCarrito").setAttribute("max",max);
    	}
    </script>
    <!--MURO-->
    <jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="<%=tipo.getNombre()+'s'%>" /></jsp:include>
    <div id="bloqueLista">
		<div style="float:left;height:40px;line-height:40px;margin-left:20px">
			Precio Minimo:
			<input onchange="ordenarElem(1)" id="min" <%if(request.getParameter("min") != null){%>value="<%=request.getParameter("min")%>"<%}%> type="text" placeholder="ej. 1" style="background-color: rgba(0,0,0,0);height: 19px;border-style: solid;border-width: 0px 0px 1px 0px;border-color: rgb(100,100,100);padding-left: 5px;width:100px;color:rgb(100,100,100)"></input>	
		</div>
		<div style="float:left;height:40px;line-height:40px;margin-left:50px">
			Precio Maximo:
			<input onchange="ordenarElem(1)" id="max" <%if(request.getParameter("max") != null){%>value="<%=request.getParameter("max")%>"<%}%> type="text" placeholder="ej. 1000" style="background-color: rgba(0,0,0,0);height: 19px;border-style: solid;border-width: 0px 0px 1px 0px;border-color: rgb(100,100,100);padding-left: 5px;width:100px;color:rgb(100,100,100)"></input>	
		</div>
		<div style="float:left;height:40px;line-height:40px;margin-left:50px">
			Nombre:
			<input onchange="ordenarElem(1)" id="nom" <%if(request.getParameter("nomb") != null){%>value="<%=request.getParameter("nomb")%>"<%}%> type="text" placeholder="ej. Rojo" style="background-color: rgba(0,0,0,0);height: 19px;border-style: solid;border-width: 0px 0px 1px 0px;border-color: rgb(100,100,100);padding-left: 5px;width:100px;color:rgb(100,100,100)"></input>	
		</div>
		<div style="float:left;height:40px;line-height:40px;margin-left:50px">
			Ordenar Por:
			<select onchange="ordenarElem(1)" id="orden" style="background-color: rgba(0,0,0,0);border-color:rgb(100,100,100);border-width: 0px 0px 1px 0px;height:19px;color:rgb(100,100,100)">
				<option selected value="1">Nombre(Descendente)</option>
				<option <%if(request.getParameter("sort") != null && request.getParameter("sort").equals("2")){%>selected<%}%> value="2">Nombre(Ascendente)</option>
				<option <%if(request.getParameter("sort") != null && request.getParameter("sort").equals("3")){%>selected<%}%> value="3">Menor Precio</option>
				<option <%if(request.getParameter("sort") != null && request.getParameter("sort").equals("4")){%>selected<%}%> value="4">Mayor Precio</option>
			</select>
		</div>
		<%if(usuario != null && usuario.getTipo().getId() == 1){%><a class="btAgregarProducto" style="margin-top:5px;height:30px" href="AgregarProducto.jsp?idCategoria=<%=request.getParameter("idCategoria")%>"><span id="gy" class="glyphicon glyphicon-plus" style="margin-right:5px;" aria-hidden="true" ></span>Nuev<%=tipo.getNombre().charAt(tipo.getNombre().length()-1)%> <%=tipo.getNombre()%></a><%}%>
        </div>
        <div class="bloque" id="lista" style="overflow:auto">
        	<div id="elementos" style="float:left; width:100%;">
        	<%if(listaProductos.size() != 0){%>
        		<%int i=-1;for(Producto producto : listaProductos){i++;%>
        			<%String context = request.getServletContext().getRealPath("imgs");%>
        			<%if(true){%>
        				<form action="ServletCatalogo" method="POST">
	        			 <input type="hidden" name="idProducto" value="<%=producto.getId()%>">
	        			 <input type="hidden" name="idCategoria" value="<%=tipo.getId()%>">
	        			 <div  class="elementoLista" id="elemento<%=i%>" style="padding-right:0; overflow: hidden;background-color:rgba(240,240,240,1);;background-image: url('./imgs/perfil/<%=producto.getUrlImagen()%>');color:black;background-size: cover;)">
			                <div class="imgElem" style="opacity:1;background-colot:rgba(0,0,0,0);">
			                	<%if(usuario != null){%>
			                		<%if(usuario.getTipo().getId() == 1){%>
			                			<button class="agregarCarrito" name="btEliminar" type="button" onclick="eliminar('<%=producto.getNombre()%>',<%=producto.getId()%>)" value="btEliminar"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
			                			<button class="agregarCarrito" name="btModificar" onclick="modificar(<%=producto.getId()%>)" type="button" value="btModificar"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button>
									<%}%>
			                			<button class="agregarCarrito" name="btAgregar"  type="button" onclick="establecerCantidad('<%=producto.getNombre()%>',<%=producto.getId()%>,'./imgs/perfil/<%=producto.getUrlImagen()%>','<%=producto.getStock()%>')" value="btAgregar"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></button>
			                	<%}%>
			                </div>
			                <div class="bloqueDesc" onclick="verProducto('Producto.jsp?idProducto=<%=producto.getId()%>')">
			                <div style="width:100%;height:15%;float:left;">
			                <div class="precioElem" style="margin-left:5%; width: 50%; float:left;vertical-align:middle;text-align: left;font-family: Playlist;">
			                    $<label style="font-size:25px" id="precioItem<%=i%>"><%=producto.getPrecio() - (producto.getPrecio() * producto.getDescuento() / 100)%></label>
			                </div>
			                <%if(producto.getDescuento() > 0) {%>
			                <div class="precioElem" style="font-size:20px;color:rgb(230,0,0);width: 45%; float:left;vertical-align:middle;text-align: left;font-family: Playlist;">
			                    $<label style=""><%=producto.getDescuento()%> OFF</label>
			                </div>
			                <%}else{%>
			                <div class="precioElem" style="width: 45%; float:left;vertical-align:middle;text-align: left;font-family: Playlist;">
			                    <label style="display:none"><%=producto.getDescuento()%></label>
			                </div>
			                <%}%>
			                </div> 
			                <div class="titulo" style="height:15%;width:100%;float:left;overflow:hidden">
			                    	<label style="margin-left:5%;" id="nombreItem<%=i%>"><%=producto.getNombre()%></label>
			                    </div>
			                
			                <div class="descElem" style="width: 100%; float:left;font-family: Playlist;text-align: left;border-stlye:none;height:40%;">
			                    
			                    <div class="descripcion" style="margin-left:5%;width:90%;float:left;overflow:hidden;border-stlye:none;">
			                    	<label><%=producto.getDescripcion()%></label>
			                    </div>
			                </div>
			                </div>
	           			 </div>
	           			 </form>
        			
        			<%}%>
        			
        		<%}%>
        	
        	<%}else{%>
        		<div id="carritoVacio" class="carrito-vacio">
					<label id="lbcarritovacio">Esta categoria no tiene ningun producto.</label>
				</div>
        	<%}%>
        	
        	</div>
            	<div id="paginador" class="paginador" style="font-size:20px;width:100%;height:40px;line-height:40px;text-align:center;float:left;position:absolute"></div>
        </div>
    <script>
    	var xPagina = 20;
    	var tam = 0;
    	
    	<%if(request.getParameter("page") == null){%>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-80)+"px";
    	document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-80)+"px";
    	<%}else{%>
    	document.getElementById("nombre").style.height="40px";
    	document.getElementById("nombre").style.lineHeight="40px";
    	document.getElementById("nombre").style.fontSize="30px";
    	<%}%>
    	
    	function modificar(id){
    		window.location= 'ModificarProducto.jsp?idCategoria=<%=request.getParameter("idCategoria")%>&idProducto='+id.toString();
    	}
    	
    	function filtrar(){
    		var items = <%=listaProductos.size()%>;
			var min = -1;
			var max = -1;
			var fragmento = document.getElementById("nom").value.toLowerCase();
			if(document.getElementById("min").value!="")var min = parseInt(document.getElementById("min").value);
    		if(document.getElementById("max").value!="")var max = parseInt(document.getElementById("max").value);
    		for(var i=0; i<items; i++){
    			var precio = parseInt(document.getElementById('precioItem'+i).innerText);
    			var nombre = document.getElementById('nombreItem'+i).innerText.toLowerCase();
    			if (!(precio >= min && (max == -1 || precio <= max) && nombre.includes(fragmento))){
    				document.getElementById('elemento'+i).style.display="none";
    			}else{
    				document.getElementById('elemento'+i).style.display="initial";
    			}
    		}
    	}
    	filtrar();
    	   	
    	function ordenarElem(pagina){
    		var direccion = 'Catalogo.jsp?idCategoria=<%=request.getParameter("idCategoria")%>';
    		direccion += '&sort='+document.getElementById("orden").value;
    		if(document.getElementById("min").value!="")direccion += '&min='+document.getElementById("min").value;
    		if(document.getElementById("max").value!="")direccion += '&max='+document.getElementById("max").value;
    		if(document.getElementById("nom").value!="")direccion += '&nomb='+document.getElementById("nom").value;
    		direccion += '&page='+pagina;
    		window.location= direccion;
    	}
    	
    	function tamLista(){
    		
    		document.getElementById('lista').style.height=(document.documentElement.clientHeight-170)+"px";
    		document.getElementById('paginador').style.marginTop=(document.documentElement.clientHeight-170-40)+"px";
    		if(document.getElementById('carritoVacio') != null){
    		document.getElementById('carritoVacio').style.height=(document.documentElement.clientHeight-170)+"px";
    		document.getElementById('carritoVacio').style.lineHeight=(document.documentElement.clientHeight-170)+"px";
    		}
    	}
    	
    	setInterval(tamLista,50);
    	
        function ordenar()
        {
        	var max = <%=listaProductos.size()%>;
            tam = (document.documentElement.clientWidth-35)/6;
            for(var i=0; i<max; i++){
            document.getElementsByClassName('elementoLista')[i].style.width=tam+"px";
            document.getElementsByClassName('elementoLista')[i].style.height =tam+"px";
            document.getElementsByClassName('elementoLista')[i].style.float ="left";
            
            //document.getElementsByClassName('precioElem')[i].style.height =((tam*15)/100)+"px";
            //document.getElementsByClassName('precioElem')[i].style.lineHeight =(((tam*15)/100)-5)+"px";
            document.getElementsByClassName('precioElem')[i].style.fontSize =(((tam*15)/100)-10)+"px";

            //document.getElementsByClassName("descElem")[i].style.height =((tam*15)/100)+"px";
            //document.getElementsByClassName("descElem")[i].style.lineHeight =(((tam*15)/100)-5)+"px";
            
            document.getElementsByClassName("titulo")[i].style.height =((tam*15)/100)+"px";
            document.getElementsByClassName("titulo")[i].style.lineHeight =(((tam*15)/100))+"px";
            document.getElementsByClassName("titulo")[i].style.fontSize =(((tam*15)/100)-20)+"px";
            
            document.getElementsByClassName("descripcion")[i].style.height =((tam*35)/100)+"px";
            document.getElementsByClassName("descripcion")[i].style.lineHeight =(((tam*35)/100)/5)+"px";
            document.getElementsByClassName("descripcion")[i].style.fontSize =(((tam*35)/100)/5)+"px";
            }
        }
        
        setInterval(ordenar,50);
        var cantXPagina = <%=cantXPage%>;
        
        function crearElemento(i, texto, clase){
        	var max = <%=listaProductos.size()%>;
        	var bt = document.createElement("button");
        	//bt.id = "pagina"+i;
        	bt.setAttribute("class",clase)
        	bt.innerText = " "+texto+" ";
        	var fun = "ordenarElem("+(i)+")";
        	bt.setAttribute("onClick",fun);
        	document.getElementById("paginador").appendChild(bt);
        }
        
        
        
        function crearPaginacion(){
        	var max = <%=listaProductos.size()%>;
			var cantPaginas = Math.floor(((max-1)/cantXPagina)+1);
         
            for(var i=0; i<cantPaginas; i++){
            	crearElemento(i,i+1,"btPaginar")
            	/*
            	var bt = document.createElement("button");
            	bt.id = "pagina"+i;
            	bt.innerText = " "+(i+1)+" ";
            	bt.style.borderStyle = "none";
            	bt.style.backgroundColor = "#242323";
            	bt.style.color = "rgba(240,240,240,1)";
        		bt.style.marginLeft = "2px";
        		bt.style.marginRight = "2px";
        		bt.style.width = "30px";
        		bt.style.height = "30px";
        		bt.style.lineHeight = "30px";
        		bt.style.padding = "0";
            	var fun = "paginar("+(i+1)+","+max+")";
            	bt.setAttribute("onClick",fun);
            	document.getElementById("paginador").appendChild(bt);*/
            }
            
            var page = <%=request.getParameter("page")%>
            if(page == null)
            {
            	paginar(1,max);
            }else
            {
            	paginar(page,max);
            }
        }
        
        
        function paginar(pagina,max){
        	var max = <%=totalMax%>;
        	if(max > 0){
	        	var myNode = document.getElementById("paginador");
	        	while (myNode.firstChild) {
				    myNode.removeChild(myNode.firstChild);
				}
				var cantPaginas = Math.floor(((max-1)/cantXPagina)+1);
				if(1==pagina){
					crearElemento(1,"PRIMERA","btPaginarSel")
	        	}else{
	        		crearElemento(1,"PRIMERA","btPaginar")
	        	}
				var ant = 0;
				if(cantPaginas-5>0){
					if(pagina > 3) ant = pagina - 3;
					if(pagina+1>=cantPaginas && cantPaginas-5>0) ant = cantPaginas-5;
				}
				var h = 0
	            for(var i=ant; i<cantPaginas && h<5; i++){	
	            	if(i+1==pagina){
	            		crearElemento(i+1,i+1,"btPaginarSel")
	            	}else{
	            		crearElemento(i+1,i+1,"btPaginar")
	            	}
	            	h++;
	            }
	            if(cantPaginas==pagina){
	            	crearElemento(cantPaginas,"ULTIMA","btPaginarSel")
	        	}else{
	        		crearElemento(cantPaginas,"ULTIMA","btPaginar")
	        	}
        	}
        }
        
        var page = <%=request.getParameter("page")%>
        if(page == null)
        {
        	paginar(1,max);
        }else
        {
        	paginar(page,max);
        }
       
        
        function verProducto(link){
        	location.href=link;
        }
    </script>
    <%}%>
</body>
</html>