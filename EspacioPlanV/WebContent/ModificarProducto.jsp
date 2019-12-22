<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Modifica Producto-PlanV</title>
<jsp:include page="Includes.html"></jsp:include>
<link rel="stylesheet" type="text/css" href="css/Catalogo.css">
</head>
<body style="overflow:hidden">
	<jsp:include page="barraNavegacion.jsp"></jsp:include>
	<jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Modificar Producto" /></jsp:include>
	<div id="poductoNuevo">
		<form action="ServletModificarProducto" enctype="MULTIPART/FORM-DATA" method="POST">
		<div id="editor" style="width:100%;background-color:rgb(240,240,240);padding:20px">
			<input name="id" value="<%=request.getParameter("idProducto")%>" style="display:none">
			<%@ page import= "entidad.*" %>
			<%@ page import= "negocioImpl.*" %>
			<%@ page import="java.util.ArrayList"%>
			<% Producto producto = new ProductoNegImpl().ObtenerProducto(Integer.parseInt(request.getParameter("idProducto")));%>
			<input name="tipoProducto" value="<%=request.getParameter("idCategoria")%>" style="display:none">
			<div style="width:20%;float:left;height:49%">
				<div id="imgProducto" style="border-style:solid;border-width:1px;border-color:rgb(30,30,30);padding:2px;float:left;max-height:100%">
						<div class="agregarImagen">
							<button type="button" id="btImg" onclick="clickImagenPerfil()" name="imgPerfil" value="./img/1.jpg" style="font-family:playlist;font-size: 30px;width:100%;height:100%;border-style:none;background-color:rgba(0,0,0,0);background-size:cover;background-position:center;background-image:url(./imgs/perfil/<%=producto.getUrlImagen()%>)"></button>
						</div>
						<input value="<%=producto.getUrlImagen()%>" name="nombreImg" style="display:none">
						<input name="imgPerfilFile" id="addImagePerfil" onchange="addImgPerfil()" style="display:none" type="file">
				</div>
			</div>
			<div style="width:40%;float:left;height:49%;margin-top:1%">
				<div style="color: #13aff0;float: left;width: 90%;height: 60px;margin-left: 5%;line-height: 30px;margin-top: 10px;font-size: 1.2em;">
					<label style="font-weight: 100;float: left;font-size: 15px;width: 100%;height: 15px;color: rgb(80,80,80);">Nombre:</label>
					<input type="text" id="name" required="required" value="<%=producto.getNombre()%>" name="nombre" style="background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 0px 0px 1px 0px;height: 30px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);">
				</div>
				<div style="color: #13aff0;float: left;width: 42.5%;height: 60px;margin-left: 5%;line-height: 30px;margin-top: 10px;font-size: 1.2em;">
					<label style="font-weight: 100;float: left;font-size: 15px;width: 100%;height: 15px;color: rgb(80,80,80);">Precio:</label>
					<input type="text" name="precio" required="required" value="<%=producto.getPrecio()%>" style="background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 0px 0px 1px 0px;height: 30px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);">
				</div>
				<div style="color: #13aff0;float: left;width: 42.5%;height: 60px;margin-left: 5%;line-height: 30px;margin-top: 10px;font-size: 1.2em;">
					<label style="font-weight: 100;float: left;font-size: 15px;width: 100%;height: 15px;color: rgb(80,80,80);">Descuento:</label>
					<input type="text" name="Descuento" required="required" value="<%=producto.getDescuento()%>" style="background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 0px 0px 1px 0px;height: 30px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);">
				</div>
				<div style="color: #13aff0;float: left;width: 42.5%;height: 60px;margin-left: 5%;line-height: 30px;margin-top: 10px;font-size: 1.2em;">
					<label style="font-weight: 100;float: left;font-size: 15px;width: 100%;height: 15px;color: rgb(80,80,80);">Stock:</label>
					<input type="text" name="Stock" required="required" value="<%=producto.getStock()%>" style="background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 0px 0px 1px 0px;height: 30px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);">
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
					<textarea type="text" required="required" value="" name="descripcion" style="resize:none;background-color: rgba(0,0,0,0);border-color: rgb(100,100,100);border-width: 1px;height: 170px;font-family: playlist;width: 100%;float: left;color: rgb(30,30,30);margin-top:10px;"><%=producto.getDescripcion()%></textarea>
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
			<input id="imagenesPrevias" value="0" name="imagenesPrevias" style="display:none">
			<div style="width:100%;height:50px;float:left;margin-top:5px">
				<button class="btPop" type="submit" name="btAgregar" style="height: 40px;float: right;border-style: none;color: black;">Agregar Producto</button>
				<button class="btPop" type="button" onclick="volver()" style="height: 40px;float: right;border-style: none;color: black;margin-right:10px;">Volver al catalogo</button>
			</div>
		</div>
		</form>
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
	
    function addImgCargada(url){
		var div = document.createElement("div");
		div.setAttribute("id","img"+contImg);
		div.style.backgroundColor = "rgba(0,0,0,0)";
		div.style.borderStyle = "solid";
		div.style.borderWidth = "1px";
	    div.style.backgroundSize = "cover";
	    div.style.marginLeft =  "10px";
	    div.style.maxHeight = "100%";
	    div.style.flex = "0 0 auto";
	    div.style.padding = "2px";
	    div.style.backgroundPosition = "center";
	    var div2 = document.createElement("div");
		div2.style.backgroundImage = "url(./imgs/detalle/"+url+")"; 
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
		eliminar.setAttribute("onclick",'ocultar('+contImg+')');
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
		file.value = url;
		file.setAttribute("id","file"+contImg.toString());
		file.setAttribute("name","file"+contImg.toString());
		file.style.display = "none";
		document.getElementById("imgs").appendChild(file);
		var estado = document.createElement("input");
		estado.value = true;
		estado.setAttribute("id","estado"+contImg.toString());
		estado.setAttribute("name","estado"+contImg.toString());
		estado.style.display = "none";
		document.getElementById("imgs").appendChild(estado);
		contImg++;
		document.getElementById("contador").value = contImg.toString();
		document.getElementById("imagenesPrevias").value = contImg.toString();
		scroll = document.getElementById("cuadros").scrollWidth;
		document.getElementById("cuadros").scrollTo(document.getElementById("cuadros").scrollWidth,0);
    }
    
    <% ArrayList<ImagenProducto> lista = producto.getListaImagenes();
	for(int i=0; i<lista.size(); i++){%>
    	addImgCargada('<%=lista.get(i).getUrlImagen()%>');
	<%}%>
    
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
    	document.getElementById("imgs").removeChild(document.getElementById("img"+id.toString()));
    	document.getElementById("imgs").removeChild(document.getElementById("file"+id.toString()));
    }
    
    function ocultar(id){
    	document.getElementById("imgs").removeChild(document.getElementById('img'+id.toString()));
    	document.getElementById('estado'+id.toString()).value = false;
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