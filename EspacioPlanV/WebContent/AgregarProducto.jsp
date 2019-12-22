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
	<link rel="stylesheet" href="./css/popup.css">
	<%@ page import= "entidad.*" %>
	<%@ page import= "negocioImpl.*" %>
	<%
	TipoProducto tipo = new TipoProductoNegImpl().ObtenerTipoProducto(Integer.parseInt(request.getParameter("idCategoria")));
	String titulo = "Nuev"+tipo.getNombre().charAt(tipo.getNombre().length()-1)+" "+tipo.getNombre();
	%>
	<jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="<%=titulo%>" /></jsp:include>
	
	<div id="poductoNuevo">
		<form action="ServletAgregarProducto" enctype="MULTIPART/FORM-DATA" method="POST">
		<div id="popupEliminar" class="overlay" style="display:none">
			<div class="popupBody" style="overflow: hidden">
				<div style="width:100%;float:left;overflow: hidden;height: 20px;"><div style="float:right"><a class="cerrar" href="#" onclick="cerrarMensaje('popupEliminar')">&times;</a></div></div>
				<div style="width:100%;float:left;text-align:center"><h2 style="margin: 0;font-size: 1.2em;" id="mensajeEliminar"></h2></div>
		        <div style="width:100%;float:left;text-align:center;margin-top: 10px;">
		        <input type="submit" class="btPop"  name="btEliminar" value="SI" style="border-style: none;cursor: pointer;margin-right:10px;width: 70px;">
		    	<input type="button" class="btPop"  value="NO" onclick="cerrarMensaje('popupEliminar')" style="border-style: none;cursor: pointer;margin-left:10px;width: 70px;"></div>
		    </div>
	    </div>
	    <input type="text" id="idEliminar" name="idProducto" style="display:none">
	    <input type="text" id="idCategoria" name="idCategoria" style="display:none">
		<script>
			function cerrarMensaje(mensaje){
				document.getElementById(mensaje).style.display = "none";
			}
	    	function agregar(){
	    		document.getElementById("popupEliminar").style.display="initial";
	    		document.getElementById("mensajeEliminar").innerText = 'Esta seguro que desea agregar ' + document.getElementById("name").value +' al catalogo';
	    	}
		</script>
		<div id="editor" style="width:100%;background-color:rgb(240,240,240);padding:20px">
			<input name="tipoProducto" value="<%=request.getParameter("idCategoria")%>" style="display:none">
			<div style="width:20%;float:left;height:49%">
				<div id="imgProducto" style="border-style:solid;border-width:1px;border-color:rgb(30,30,30);padding:2px;float:left;max-height:100%">
						<div class="agregarImagen">
							<button type="button" id="btImg" onclick="clickImagenPerfil()" name="imgPerfil" value="./img/1.jpg" style="font-family:playlist;font-size: 30px;width:100%;height:100%;border-style:none;background-color:rgba(0,0,0,0);background-size:cover;background-position:center">Imagen de perfil</button>
						</div>
						<input required="required"  name="imgPerfilFile" id="addImagePerfil" onchange="addImgPerfil()" style="display:none" type="file">
				</div>
			</div>
			<div style="width:40%;float:left;height:49%;margin-top:1%">
				<div style="color: #13aff0;float: left;width: 90%;height: 60px;margin-left: 5%;line-height: 30px;margin-top: 10px;font-size: 1.2em;">
					<label style="font-weight: 100;float: left;font-size: 15px;width: 100%;height: 15px;color: rgb(80,80,80);">Nombre:</label>
					<input required="required"  type="text" id="name" name="nombre" style="background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 0px 0px 1px 0px;height: 30px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);">
				</div>
				<div style="color: #13aff0;float: left;width: 42.5%;height: 60px;margin-left: 5%;line-height: 30px;margin-top: 10px;font-size: 1.2em;">
					<label style="font-weight: 100;float: left;font-size: 15px;width: 100%;height: 15px;color: rgb(80,80,80);">Precio:</label>
					<input required="required"  type="text" name="precio" style="background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 0px 0px 1px 0px;height: 30px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);">
				</div>
				<div style="color: #13aff0;float: left;width: 42.5%;height: 60px;margin-left: 5%;line-height: 30px;margin-top: 10px;font-size: 1.2em;">
					<label style="font-weight: 100;float: left;font-size: 15px;width: 100%;height: 15px;color: rgb(80,80,80);">Descuento:</label>
					<input required="required"  type="text" name="Descuento" style="background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 0px 0px 1px 0px;height: 30px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);">
				</div>
				<div style="color: #13aff0;float: left;width: 42.5%;height: 60px;margin-left: 5%;line-height: 30px;margin-top: 10px;font-size: 1.2em;">
					<label style="font-weight: 100;float: left;font-size: 15px;width: 100%;height: 15px;color: rgb(80,80,80);">Stock:</label>
					<input required="required"  type="text" name="Stock" style="background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 0px 0px 1px 0px;height: 30px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);">
				</div>
				<div style="color: rgb(80,80,80);float: left;width: 42.5%;height: 30px;margin-left: 5%;line-height:30px;margin-top: 30px;font-size: 15px;">
					<label id="visible" style="width:0px; transition: width 1s;background-color: #2196F3;padding-left: 30px;padding-right: 0px;" class="container">&nbsp;Visible
					  <input type="checkbox" name="visible" onclick="cambiarCheck(this.checked)">
					  <span class="checkmark"></span>
					</label>
				</div>
			</div>
			<div style="width:40%;float:left;height:50%">
				<div style="color: #13aff0;float: left;width: 90%;height: 60px;margin-left: 5%;line-height: 30px;margin-top: 10px;font-size: 1.2em;">
					<label style="font-weight: 100;float: left;font-size: 15px;width: 100%;height: 15px;color: rgb(80,80,80);">Descripcion:</label>
					<textarea required="required"  type="text" name="descripcion" style="resize:none;background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 1px;height: 170px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);margin-top:10px;"></textarea>
				</div>
			</div>
			<div style="width:100%;height:50%;float:left">
				<div style="width:20%;height:100%;float:left;text-align: center;border-style:solid;border-width:0px 1px 0px 0px;align-items: center;display: inline-flex;">
					<label style="font-family:playlist;font-size: 30px;">Imagenes Del Producto</label>
				</div>
				<div style="width:5%;height:100%;float:left;text-align: center;align-items: center;display: table;font-size:3em">
					<span style="vertical-align: middle;display: table-cell;cursor:pointer" onclick="toIzquierda()" class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>
				</div>
				<div id="cuadros" style="overflow:horizontal;width:70%;height:100%;float:left;text-align: center;border-width:0px 1px 0px 0px;align-items: center;display: inline-flex;max-height: 100%;overflow: scroll;overflow-y: hidden;overflow-x: scroll;white-space: nowrap;display: inline-block;display: flex;flex-wrap: nowrap;">
					<div id="imgs" style="height: 100%;display:flex"></div>
					<div  id="nuevaImagen" style="border-style:solid;border-width:1px;border-color:rgb(30,30,30);padding:2px;margin-left:10px;float:left;max-height:100%">
						<div class="agregarImagen">
							<input type="button" onclick="clickImagen()" name="otrasImagenes" style="width: 100%;font-family:playlist;font-size: 30px;padding: 0;margin: 0;border-style: none;height: 100%;background-color: rgba(0,0,0,0);" value="AGREGAR IMAGEN">
						</div>
					</div>
					<input id="addImage" onchange="addImg()" style="display:none" type="file">
				</div>
				<div style="width:5%;height:100%;float:left;text-align: center;align-items: center;display: table;font-size:3em">
					<span style="vertical-align: middle;display: table-cell;cursor:pointer" onclick="toDerecha()" class="glyphicon glyphicon-menu-right" aria-hidden="true"></span>
				</div>
			</div>
			<input id="contador" value="0" name="contador" style="display:none">
			<div style="width:100%;height:50px;float:left;margin-top:5px">
				<button class="btPop" type="submit" name="btAgregar" style="height: 40px;float: right;border-style: none;color: black;">Añadir <%=tipo.getNombre()%> al catalogo</button>
				<button class="btPop" type="button" onclick="volver()" style="height: 40px;float: right;border-style: none;color: black;margin-right:10px;">Volver al catalogo</button>
			</div>
		</div>
		</form>
		<script></script>
	</div>
	<script>
	
	function volver(){
		location.href='Catalogo.jsp?idCategoria=<%=request.getParameter("idCategoria")%>';
	}
	
	var scroll = 0;
	
	function toDerecha(){ 
		scroll += 500;
		document.getElementById("cuadros").scrollTo(scroll,0);
	}
	
	function toIzquierda(){
		scroll -= 500;
		document.getElementById("cuadros").scrollTo(scroll,0);
	}
	
	
	function clickImagenPerfil(){
		document.getElementById("addImagePerfil").click();
	}
	
	function addImgPerfil(){
		var curFiles = document.getElementById("addImagePerfil").files;
		document.getElementById("btImg").innerText = "";
		document.getElementById("btImg").style.backgroundImage = "url("+window.URL.createObjectURL(curFiles[0])+")";
	}
	
	function clickImagen(){
		document.getElementById("addImage").click();
	}
	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
	
    var contImg = 0;
    
    function addImg(){
    	var curFiles = document.getElementById("addImage").files;
    	var div = document.createElement("div");
		div.setAttribute("id","img"+contImg);
		div.style.backgroundColor = "rgba(0,0,0,0)";
		div.style.borderStyle = "solid";
		div.style.borderWidth = "1px";
	    div.style.marginLeft =  "10px";
	    div.style.maxHeight = "100%";
	    div.style.flex = "0 0 auto";
	    div.style.padding = "2px";
	    var div2 = document.createElement("div");
		div2.style.backgroundImage = "url("+window.URL.createObjectURL(curFiles[0])+")"; 
		div2.style.width = "100%";
		div2.style.height = "100%";
		div2.style.backgroundPosition = "center";
		div2.style.backgroundSize = "cover";
		div.appendChild(div2);
		div.style.float = "left";
		div.style.minWidth = (((document.documentElement.clientWidth-80)*20)/100)+'px';
		div.style.width = (((document.documentElement.clientWidth-80)*20)/100)+'px';
		div.style.maxWidth = (((document.documentElement.clientWidth-80)*20)/100)+'px';
		div.style.height = (((document.documentElement.clientWidth-80)*20)/100)+'px';
		var eliminar = document.createElement("button");
		eliminar.setAttribute("type","button");
		eliminar.setAttribute("onclick",'eliminar(img'+contImg+')');
		eliminar.style.float = "right";
		eliminar.style.marginRight = "10px";
		eliminar.style.marginTop = "10px";
		eliminar.style.borderStyle = "none";
		eliminar.style.backgroundColor = "rgba(0,0,0,0)";
		var icono = document.createElement("span");
		icono.setAttribute("class","glyphicon glyphicon-trash");
		icono.setAttribute("aria-hidden","true");
		eliminar.appendChild(icono);
		div2.appendChild(eliminar);
		document.getElementById("imgs").appendChild(div);
		var file = document.createElement("input");
		file.setAttribute("type","file");
		file.files = document.getElementById("addImage").files;
		file.setAttribute("id","file"+contImg.toString());
		file.setAttribute("name","file"+contImg.toString());
		file.style.display = "none";
		document.getElementById("imgs").appendChild(file);
		contImg++;
		document.getElementById("contador").value = contImg.toString();
		scroll = document.getElementById("cuadros").scrollWidth;
		document.getElementById("cuadros").scrollTo(document.getElementById("cuadros").scrollWidth,0);
    }
    
    function eliminar(id){
    	document.getElementById("imgs").removeChild(id);
    }
	
    
    function tamNuevo(){
        document.getElementById("poductoNuevo").style.marginLeft="20px";
        document.getElementById("poductoNuevo").style.float="left";
        document.getElementById("poductoNuevo").style.width=(document.documentElement.clientWidth-40)+'px';
        document.getElementById("poductoNuevo").style.height=(document.documentElement.clientHeight-90)+"px";
        
        document.getElementById("editor").style.marginTop='20px';
        document.getElementById("editor").style.height=(document.documentElement.clientHeight-150)+"px";
        
        document.getElementById("imgProducto").style.width=(((document.documentElement.clientWidth-80)*20)/100)+'px';
        document.getElementById("imgProducto").style.height=(((document.documentElement.clientWidth-80)*20)/100)+'px';
        document.getElementById("nuevaImagen").style.minWidth=(((document.documentElement.clientWidth-80)*20)/100)+'px';
        document.getElementById("nuevaImagen").style.width=(((document.documentElement.clientWidth-80)*20)/100)+'px';
        document.getElementById("nuevaImagen").style.maxWidth=(((document.documentElement.clientWidth-80)*20)/100)+'px';
        document.getElementById("nuevaImagen").style.height=(((document.documentElement.clientWidth-80)*20)/100)+'px';
    }
    tamNuevo();
    
    function cambiarCheck(estado){
    	if(estado){
    		document.getElementById("visible").style.width='100%';
    		document.getElementById("visible").style.backgroundColor='#2196F3';
    	}else{
    		document.getElementById("visible").style.width='0%';
    		document.getElementById("visible").style.backgroundColor='#ccc';
    	}
    }
    </script>
</body>
</html>