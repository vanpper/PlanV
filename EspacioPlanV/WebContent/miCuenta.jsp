<%@ page import= "entidad.*" %>
<%@ page import= "negocioImpl.*" %>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="./css/micuenta-style.css">
	<link rel="stylesheet" href="./css/popup.css">
	<jsp:include page="Includes.html"></jsp:include>
	<script>function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}</script>
	<title>Mi cuenta</title>
	
	 <script>
			function validarCampos() {
                var a = document.getElementById("txtNombre").value;
                var b = document.getElementById("txtApellido").value;
                var c = document.getElementById("txtDNI").value;
                var d = document.getElementById("dateNacimiento").value;
                var e = document.getElementById("selectProvincia").value;
                var f = document.getElementById("txtCiudad").value;

                if(a == "" || b == "" || c == "" || d == "" || e == "" || f == "")
                {
                    alert("Hay campos que no pueden quedar vacios");
                    return false;
                }
                return true;
            }
		</script>
	
	<%
		HttpSession mySession = request.getSession(false);
		Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
		ArrayList<Provincia> listaProvincias = new ProvinciaNegImpl().ObtenerTodas();
		
		if(request.getAttribute("resultadoModificarDatos") != null)
		{
			boolean resultado = (boolean)request.getAttribute("resultadoModificarDatos");
			
			if(resultado)
			{
				%><div id="popup" class="overlay"><div id="popupBody"><h2>Datos modificados</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
           		<p>Se han modificado los datos con exito.</p></div></div></div><%
			}
			else
			{
				%><div id="popup" class="overlay"><div id="popupBody"><h2>Error al modificar</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
           		<p>Ha ocurrido un error al modificar los datos.</p></div></div></div><%
			}
		}
		
		if(request.getAttribute("resultadoCambiarClave") != null)
		{
			boolean resultado = (boolean)request.getAttribute("resultadoCambiarClave");
			
			if(resultado)
			{
				%><div id="popup" class="overlay"><div id="popupBody"><h2>Clave cambiada</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
           		<p>Se ha cambiado la clave con exito.</p></div></div></div><%
			}else
			{
				%><div id="popup" class="overlay"><div id="popupBody"><h2>Error al modificar</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
           		<p>Ha ocurrido un error al modificar la contraseña.</p></div></div></div><%
			}
		}
	%>
	
</head>
<body class="micuenta-body">
    
    <jsp:include page="barraNavegacion.jsp"></jsp:include>
	<jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Mi cuenta" /></jsp:include>
    
    <%if(usuario != null){%>
		
		<div class="ventana-central">
        <form action="ServletCuenta?Param=modificarDatos" method="POST" onsubmit="return validarCampos()">
            <div class="item">
                <label for="txtNombre">Nombre</label>
                <input type="text" value="<%=usuario.getNombre()%>" name="txtNombre" id="txtNombre">
            </div>
            <div class="item2">
                <label for="txtApellido">Apellido</label>
                <input type="text" value="<%=usuario.getApellido()%>" name="txtApellido" id="txtApellido">
            </div>
            <div class="item">
                <label for="txtDNI">DNI</label>
                <input type="text" value="<%=usuario.getDni()%>" name="txtDNI" id="txtDNI">
            </div>
            <div class="item2">
                <label for="dateNacimiento">Fecha de nacimiento</label>
                <input type="date" value="<%=usuario.getFechaNacimiento().toDateFormat()%>" name="dateNacimiento" id="dateNacimiento">
            </div>
            <div class="item">
                <label for="txtTelefono">Telefono</label>
                <input type="text" value="<%=usuario.getTelefono()%>" name="txtTelefono" id="txtTelefono">
            </div>
            <div class="item2">
                <label for="selectProvincia">Provincia</label>
                <select  onchange="cambiarProvincia()" name="selectProvincia" id="selectProvincia">
                    <option value="" disabled selected>Seleccione su provincia</option>
                    <%for(Provincia provincia : listaProvincias){%>
                    	<option value="<%=provincia.getId()%>"><%=provincia.getNombre()%></option>
                    <%}%>
                    <script>document.getElementById("selectProvincia").value = <%=usuario.getProvincia().getId()%></script>
               	</select>
            </div>
           <div class="item">
                <label for="selectProvincia">Localidad</label> <br>
                <input type="text" name="txtCiudad" id="txtCiudad" style="display:none">
                <%for(int i=0;i<listaProvincias.size();i++){%>
           			<select onchange="cambiarLocalidad()" id="provincia<%=listaProvincias.get(i).getId()%>" <%if(i==0){%>style="display:initial"<%}else{%>style="display:none"<%}%>>
                	<%ArrayList<Ciudad> ciudades = new ProvinciaNegImpl().ObtenerCiudades(i+1);%>
                	<%for(int j=0;j<ciudades.size();j++){%>
                		<option id="<%=listaProvincias.get(i).getId()%><%=j%>" value="<%=ciudades.get(j).getId()%>"><%=ciudades.get(j).getNombre()%></option>
               		<%}%>
               		</select>
                <%}%></div>
                <script>
                document.getElementById("provincia<%=usuario.getProvincia().getId()%>").value = <%=usuario.getCiudad()%>
                document.getElementById("txtCiudad").value = <%=usuario.getCiudad()%>;
            	
            	function cambiarLocalidad(){
            		document.getElementById("txtCiudad").value = document.getElementById("provincia"+document.getElementById("selectProvincia").value).value;
            	}
            	
            	function cambiarProvincia(){
            		var provincias = <%=listaProvincias.size()%>
            		var prov = document.getElementById("selectProvincia").value;
            		for(var i=1; i<=provincias; i++){
            			document.getElementById("provincia"+i).style.display = "none"
            		}
            		document.getElementById("provincia"+prov).style.display = "initial"
            		document.getElementById("provincia"+prov).value = document.getElementById(prov+"0").value;
            		document.getElementById("txtCiudad").value = document.getElementById("provincia"+prov).value;
            	}
            	
            	function unaVez(){
            		var provincias = <%=listaProvincias.size()%>
            		var prov = document.getElementById("selectProvincia").value;
            		for(var i=1; i<=provincias; i++){
            			document.getElementById("provincia"+i).style.display = "none"
            		}
            		document.getElementById("provincia"+prov).style.display = "initial"
            		document.getElementById("provincia"+prov).value = <%=usuario.getCiudad()%>;
            	}
            	unaVez();
                </script>
            <div class="item2">
                <label for="txtDireccion">Direccion</label>
                <input type="text" value="<%=usuario.getDireccion()%>" name="txtDireccion" id="txtDireccion">
            </div>
            <div class="item3">
                <a href="CambiarContraseña.jsp" id="modificarClave">Modificar contraseña</a>
            </div>
            <div class="item4">
                <button type="submit" name="btnGuardar" id="btnGuardar">Guardar</button>
            </div>
		</form>
    </div>

	<%}else{%>
		<div class="vacio">
			<label id="lbvacio">Para ver tus datos personales, ingresa en tu cuenta</label>
		</div>
	<%}%>
	
	
	<script>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("cuadroTotal").style.height=(document.documentElement.clientHeight-90)+"px";
    </script>
	
</body>
</html>