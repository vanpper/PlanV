<%@ page import="java.util.ArrayList"%>
<%@ page import= "entidad.*" %>
<%@ page import= "negocioImpl.*" %>
<%@ page import= "negocio.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">

        <link rel="stylesheet" href="./css/Registrarse.css">
        <link rel="stylesheet" href="./css/popup.css">
        <title>Registrate en PlanV</title>
        <jsp:include page="Includes.html"></jsp:include>
        
		<div id="popupForm" class="overlay" style="display:none">
		<div class="popupBody"><h2 style="font-size:15px" id="mensajePopUp"></h2>
		<a id="cerrar" href="#" onclick="cerrarMensaje('popupForm')">&times;</a>
		<div class="popupContent">
        <p ></p></div></div></div>
        
        <script>
			function validarCampos() {
                var a = document.getElementById("txtNombre").value;
                var b = document.getElementById("txtApellido").value;
                var c = document.getElementById("txtDNI").value;
                var d = document.getElementById("dateNacimiento").value;
                var e = document.getElementById("selectProvincia").value;
                var f = document.getElementById("txtCiudad").value;
                var g = document.getElementById("txtEmail").value;
                var h = document.getElementById("txtClave").value;
                var i = document.getElementById("txtClave2").value;

                if(a == "" || b == "" || c == "" || d == "" || e == "" || f == "" || g == "" || h == "" || i == "")
                {
                	document.getElementById("popupForm").style.display="initial";
                	document.getElementById("mensajePopUp").innerText="Hay campos que no pueden quedar vacios";
                    return false;
                }
                if(h != i)
                {
                	document.getElementById("popupForm").style.display="initial";
                	document.getElementById("mensajePopUp").innerText="Ambas contraseñas deben se iguales";
                    return false;
                }
                document.getElementById("btnCrearCuenta").click();
                return true;
            }
			
			function cerrarMensaje(mensaje){document.getElementById(mensaje).style.display = "none";}
		</script>
        
        
        
        <%
        	ArrayList<Provincia> listaProvincias = new ProvinciaNegImpl().ObtenerTodas();
        
        	if(request.getAttribute("registroResultado") != null)
        	{
        		%><div id="popup" class="overlay"><div class="popupBody"><h2>No pudimos crear tu cuenta</h2><a id="cerrar" href="#" onclick="cerrarMensaje('popup')">&times;</a><div class="popupContent">
            	<p>Ha ocurrido un error al intentar crear tu cuenta. Intentalo nuevamente mas tarde.</p></div></div></div><%
        	}
        	
        	
        %>
        
</head>
<body id="bodyRegistrarse" class="ivan">
	<jsp:include page="barraNavegacion.jsp"></jsp:include>
	    <jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Registrarse" /></jsp:include>
        <div class="centrar">
            <form action="ServletRegistrarse" method="post" onsubmit="return validarCampos()"  autocomplete="off">
                <label for="txtNombre">Nombre</label> <br>
                <input type="text" name="txtNombre" id="txtNombre"  autocomplete="off">
                <br><br>
                <label for="txtApellido">Apellido</label> <br>
                <input type="text" name="txtApellido" id="txtApellido">
                <br><br>
                <label for="txtDNI">DNI</label> <br>
                <input type="text" name="txtDNI" id="txtDNI">
                <br><br>
                <label for="dateNacimiento">Fecha de nacimiento</label> <br>
                <input type="date" name="dateNacimiento" id="dateNacimiento">
                <br><br>
                <label for="txtTelefono">Telefono</label> <br>
                <input type="text" name="txtTelefono" id="txtTelefono">
                <br><br>
                <label for="selectProvincia">Provincia</label> <br>
                <select name="selectProvincia" onchange="cambiarProvincia()" id="selectProvincia">
                	<%for(int i=0; i<listaProvincias.size(); i++){%>
                		<option  value="<%=listaProvincias.get(i).getId()%>"><%=listaProvincias.get(i).getNombre()%></option>
                	<%}%>
                </select>
                <br><br>
                <label for="selectProvincia">Localidad</label> <br>
                <input type="text" name="txtCiudad" id="txtCiudad" style="display:none">
                <%for(int i=0;i<listaProvincias.size();i++){%>
           			<select onchange="cambiarLocalidad()" id="provincia<%=listaProvincias.get(i).getId()%>" <%if(i==0){%>style="display:initial"<%}else{%>style="display:none"<%}%>>
                	<%ArrayList<Ciudad> ciudades = new ProvinciaNegImpl().ObtenerCiudades(i+1);%>
                	<%for(int j=0;j<ciudades.size();j++){%>
                		<option id="<%=listaProvincias.get(i).getId()%><%=j%>" value="<%=ciudades.get(j).getId()%>"><%=ciudades.get(j).getNombre()%></option>
               		<%}%>
               		</select>
                <%}%>
                <br><br>
                <label for="txtDireccion">Direccion</label> <br>
                <input type="text" name="txtDireccion" id="txtDireccion">
                <br><br>
                <label for="txtEmail">Email</label> <br>
                <input type="email" name="txtEmail" id="txtEmail">
                <br><br>
                <label for="txtClave">Clave</label> <br>
                <input type="password" name="txtClave" id="txtClave">
                <br><br>
                <label for="txtClave">Repetir Clave</label> <br>
                <input type="password" name="txtClave2" id="txtClave2">
                <br><br><br>
                <div class="center"><button type="button" onclick="validarCampos()" >Crear cuenta</button><button type="submit" style="display:none" id="btnCrearCuenta" name="btnCrearCuenta"></button></div>
            </form>
        </div>
        <script>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
    	document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    	
    	document.getElementById("txtCiudad").value = document.getElementById("provincia1").value;
    	
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
    	</script>
    </body>
</html>