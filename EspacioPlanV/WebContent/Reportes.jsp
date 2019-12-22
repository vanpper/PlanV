<%@page import="entidad.Factura"%>
<%@page import="negocioImpl.FacturaNegImpl"%>
<%@page import="negocioImpl.DetalleFacturaNegImpl"%>
<%@page import="entidad.DetalleFactura"%>
<%@page import="negocioImpl.ProductoNegImpl"%>
<%@page import="datosImpl.ProductoDaoImpl"%>
<%@page import="entidad.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="./css/reportes-style.css">
    <script src="./js/Chart.min.js"></script>
	<script src="./js/utils.js"></script>
	<jsp:include page="Includes.html"></jsp:include>
    <title>Reportes</title>
    
    <%ArrayList<Producto> listaProductos = new ArrayList<Producto>();%>
    <%ArrayList<Factura> listaFacturas = new ArrayList<Factura>();%>
    
</head>
<body class="body-reportes">
	<jsp:include page="barraNavegacion.jsp"></jsp:include>
    <jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Reportes" /></jsp:include>
    <div class="ventana-principal">
		<div class="barra-titulo">Productos mas vendidos</div>
        <div class="ventana-top-10-productos">
            <div class="barra-opciones">
                <ul class="lista-opciones">
                    <li>
                        <a href="javascript:mostrarProductosDia();" class="item-seleccionado" id="i1">Dia</a>
                        <a href="javascript:mostrarProductosSemana();" class="item-no-seleccionado" id="i2">Semana</a>
                        <a href="javascript:mostrarProductosMes();" class="item-no-seleccionado" id="i3">Mes</a>
                    </li>
                </ul>
            </div>
            <div class="visor-productos" id="visorProductos"></div>
        </div>
		<div class="barra-titulo">Cantidad de ventas</div>
        <div class="ventana-top-10-productos">
            <div class="barra-opciones">
                <ul class="lista-opciones">
                    <li>
                        <a href="javascript:aDia();" class="item-seleccionado" id="i4">Dias</a>
                        <script>
                        function aDia(){
                        	document.getElementById('graficoDia').style.display="initial";
                        	document.getElementById('graficoMes').style.display="none"
                            document.getElementById("i5").className = "item-no-seleccionado";
                    		document.getElementById("i4").className = "item-seleccionado";                        
                        }
                        function aMes(){
                        	document.getElementById('graficoDia').style.display="none";
                        	document.getElementById('graficoMes').style.display="initial"
                        	document.getElementById("i4").className = "item-no-seleccionado";
                			document.getElementById("i5").className = "item-seleccionado";
                        }
                        </script>
                        <a href="javascript:aMes();" class="item-no-seleccionado" id="i5">Meses</a>
                    </li>
                </ul>
            </div>
            <div class="visor-productos2">
            <!--<div class="contenedor-cantidad-ventas" id="cantidadVentas">0</div>-->
            	<div id="graficoDia" style="width: 650px;height: 370px;background-color:white;float: left;">
            		<div style="margin: auto;width: fit-content;height:25px;line-height:25px;text-align:center;">
            			<div class="btMostrar" onclick="VerDia('DiaTodo','#8AC6FF','btDiaTodo')" id="btDiaTodo" style="margin-right: 5px;">Todos</div>
            			<div class="btMostrar" onclick="VerDia('DiaCuaderno','#FFAB5E','btDiaCuadernos')" id="btDiaCuadernos" style="margin-right: 5px;">Cuadernos</div>
            			<div class="btMostrar" onclick="VerDia('DiaAgenda','#6CFF9D','btDiaAgendas')" id="btDiaAgendas" style="margin-right: 5px;">Agendas</div>
            			<div class="btMostrar" onclick="VerDia('DiaCalendario','#FEFF47','btDiaCalendarios')"id="btDiaCalendarios" style="margin-right: 5px;">Calendarios</div>
            			<div class="btMostrar" onclick="VerDia('DiaTarjeta','#CF7BFF','btDiaTarjetas')"id="btDiaTarjetas" style="">Tarjetas</div>
            		</div>
        			<div id="tablaGraficoDia" style="position:absolute;width: 825px;height: 250px;background-color:rgba(0,0,0,0);margin-left:50px;float:left;border-style: solid;border-color:rgb(150,150,150);border-width: 0px 0px 1px 1px;">
        			</div>
        		</div>
        		<div id="graficoMes" style="width: 650px;display:none;height: 370px;background-color:white;float: left;">
            		<div style="margin: auto;width: fit-content;height:25px;line-height:25px;text-align:center;">
            			<div class="btMostrar" onclick="VerMes('MesTodo','#8AC6FF','btMesTodo')" id="btMesTodo" style="margin-right: 5px;">Todos</div>
            			<div class="btMostrar" onclick="VerMes('MesCuaderno','#FFAB5E','btMesCuadernos')" id="btMesCuadernos" style="margin-right: 5px;">Cuadernos</div>
            			<div class="btMostrar" onclick="VerMes('MesAgenda','#6CFF9D','btMesAgendas')" id="btMesAgendas" style="margin-right: 5px;">Agendas</div>
            			<div class="btMostrar" onclick="VerMes('MesCalendario','#FEFF47','btMesCalendarios')"id="btMesCalendarios" style="margin-right: 5px;">Calendarios</div>
            			<div class="btMostrar" onclick="VerMes('MesTarjeta','#CF7BFF','btMesTarjetas')"id="btMesTarjetas" style="">Tarjetas</div>
            		</div>
        			<div id="tablaGraficoMes" style="position:absolute;width: 825px;height: 250px;background-color:rgba(0,0,0,0);margin-left:50px;float:left;border-style: solid;border-color:rgb(150,150,150);border-width: 0px 0px 1px 1px;">
        			</div>
        		</div>
        		<script>
	        		function VerDia(id,color,bt){
	        			document.getElementById('DiaTodo').style.display="none";
	        			document.getElementById("btDiaTodo").style.backgroundColor="rgb(230,230,230)";
	        			document.getElementById("DiaCuaderno").style.display="none";
	        			document.getElementById("btDiaCuadernos").style.backgroundColor="rgb(230,230,230)";
	        			document.getElementById("DiaAgenda").style.display="none";
	        			document.getElementById("btDiaAgendas").style.backgroundColor="rgb(230,230,230)";
	        			document.getElementById("DiaCalendario").style.display="none";
	        			document.getElementById("btDiaCalendarios").style.backgroundColor="rgb(230,230,230)";
	        			document.getElementById("DiaTarjeta").style.display="none";
	        			document.getElementById("btDiaTarjetas").style.backgroundColor="rgb(230,230,230)";
	        			document.getElementById(id).style.display="initial";
	        			document.getElementById(bt).style.backgroundColor=color;
	        		}
            		function VerMes(id,color,bt){
            			document.getElementById('MesTodo').style.display="none";
            			document.getElementById("btMesTodo").style.backgroundColor="rgb(230,230,230)";
            			document.getElementById("MesCuaderno").style.display="none";
            			document.getElementById("btMesCuadernos").style.backgroundColor="rgb(230,230,230)";
            			document.getElementById("MesAgenda").style.display="none";
            			document.getElementById("btMesAgendas").style.backgroundColor="rgb(230,230,230)";
            			document.getElementById("MesCalendario").style.display="none";
            			document.getElementById("btMesCalendarios").style.backgroundColor="rgb(230,230,230)";
            			document.getElementById("MesTarjeta").style.display="none";
            			document.getElementById("btMesTarjetas").style.backgroundColor="rgb(230,230,230)";
            			document.getElementById(id).style.display="initial";
            			document.getElementById(bt).style.backgroundColor=color;
            		}
            		</script>
            </div>
        </div>
		<div class="barra-titulo">Detalle facturacion</div>
        <div class="ventana-detalle-facturacion">
            <div class="barra-opciones">
                <ul class="lista-opciones">
                    <li>
                        <a href="javascript:obtenerFacturacionDia();" class="item-seleccionado" id="i7">Dia</a>
                        <a href="javascript:obtenerFacturacionSemana();" class="item-no-seleccionado" id="i8">Semana</a>
                        <a href="javascript:obtenerFacturacionMes();" class="item-no-seleccionado" id="i9">Mes</a>
                    </li>
                </ul>
            </div>
            <div class="visor-detalle-facturacion"><canvas id="canvas"></canvas></div>
        </div>
    </div>
	<script>
		function crearCuadricula(id,ancho,alto,etiquetaX,etiquetaY,tituloX,tituloY){
			var grafico = document.getElementById(id);
			grafico.style.width = ancho+"px";
			grafico.style.height = alto+"px";
			var x = etiquetaX.length-1;
			var y = etiquetaY.length-1;
			var anchoRel = ancho/x;
			var altoRel = alto/y;
			for(var i=0; i<x; i++){
				for(var j=0; j<y; j++){
					var cuadro = document.createElement("div");
					cuadro.style.borderStyle = "solid";
					cuadro.style.borderWidth = "1px 1px 0px 0px";
					cuadro.style.borderColor = "rgb(200,200,200)";
					cuadro.style.width = (anchoRel+5)+"px";
					cuadro.style.height = (altoRel+5) +"px";
					cuadro.style.position = "absolute";
					cuadro.style.top = ((j*altoRel))+"px";
					cuadro.style.left = ((i*anchoRel)-5)+"px";
					grafico.appendChild(cuadro);
				}
			}
			for(var i=0; i<=y; i++){
				var cuadro = document.createElement("div");
				cuadro.style.width = "30px";
				cuadro.style.height = "20px";
				cuadro.style.lineHeight = "20px";
				cuadro.style.fontSize = "10px";
				cuadro.style.position = "absolute";
				cuadro.style.top = (((y-i)*altoRel)-8)+"px";
				cuadro.style.left = (-36)+"px";
				cuadro.style.textAlign = "right";
				cuadro.innerText = etiquetaY[i]+"";
				grafico.appendChild(cuadro);
			}
			var labelY = document.createElement("div");
			var label = document.createElement("div");
			label.innerText = tituloY;
			//label.style.transform = "rotate(90deg)"
			labelY.appendChild(label);
			labelY.style.height="15px";
			labelY.style.width=alto+"px";
			labelY.style.position = "absolute";
			labelY.style.textAlign = "center";
			labelY.style.transformOrigin = (alto/2)+"px "+(alto/2)+"px";
			labelY.style.left = "-51px";
			labelY.style.transform = "rotate(-90deg)";
			grafico.appendChild(labelY);
			for(var i=0; i<=x; i++){
				var cuadro = document.createElement("div");
				cuadro.style.width = "50px";
				cuadro.style.height = "20px";
				cuadro.style.lineHeight = "20px";
				cuadro.style.fontSize = "10px";
				cuadro.style.position = "absolute";
				cuadro.style.top = (alto+6)+"px";
				cuadro.style.left = (i*anchoRel-25)+"px";
				cuadro.style.textAlign = "center";
				cuadro.innerText = etiquetaX[i]+"";
				grafico.appendChild(cuadro);
			}
			var labelX = document.createElement("div");
			labelX.innerText = tituloX;
			labelX.style.height="15px";
			labelX.style.width= ancho+"px";
			labelX.style.position = "absolute";
			labelX.style.textAlign = "center";
			labelX.style.top = (alto+21)+"px";
			grafico.appendChild(labelX);
		} 
		
		function dibujarGrafico(nombre,id,color,x,y,anchoG,altoG,valores,max,etiquetaX,etiquetaY,ejeX,ejeY){
			var graficoImg = document.getElementById(id);
			var grafico = document.createElement("div");
			grafico.setAttribute("id",nombre);
			var anchoRel = anchoG/x;
			var altoRel = altoG/y;
			
			for(var i=0; i<=x; i++){
				var punto = document.createElement("div");
				punto.setAttribute("class","punto");
				punto.style.top = ((((max-valores[i])/(max/10))*altoRel)-5)+"px";
				punto.style.backgroundColor = color;
				punto.style.left = ((i*anchoRel)-5)+"px";
				if(i+1 <= x){
					var linea = document.createElement("div");
					linea.setAttribute("class","linea");
					linea.style.top = (3)+"px";
					var xA = i*anchoRel;
					var xB = (i+1)*anchoRel;
					var yA = ((((max-valores[i])/(max/10))*altoRel)-5);
					var yB = ((((max-valores[i+1])/(max/10))*altoRel)-5);
					var ancho = xB-xA;
					var alto = yB-yA;
					linea.style.width = (Math.sqrt(Math.pow(ancho,2)+Math.pow(alto,2)))+"px";
					linea.style.transform = "rotate("+(Math.atan(alto/ancho)*180/Math.PI)+"deg)";
					linea.style.backgroundColor = color;
					punto.appendChild(linea);
				}
				
				var caja = document.createElement("div");
				caja.setAttribute("class","caja");
				caja.setAttribute("id","caja"+i);
				var cajaTitulo = document.createElement("div");
				cajaTitulo.setAttribute("class","cajaTexto");
				cajaTitulo.innerText = "Productos Vendidos";
				caja.appendChild(cajaTitulo);
				var cajaX = document.createElement("div");
				cajaX.setAttribute("class","cajaTexto");
				cajaX.innerText = etiquetaX+": "+ejeX[i];
				caja.appendChild(cajaX);
				var cajaY = document.createElement("div");
				cajaY.setAttribute("class","cajaTexto");
				cajaY.innerText = etiquetaY+": "+valores[i];
				caja.appendChild(cajaY);
				if(anchoG < (i*anchoRel)+150){
					caja.style.left="-145px";
				}
				if(altoG < ((((max-valores[i])/(max/10))*altoRel)-5)+45){
					caja.style.top="-40px";
				}
				punto.appendChild(caja);
				punto.setAttribute("onmouseover","mostrar('caja"+i+"')");
				punto.setAttribute("onmouseout","ocultar('caja"+i+"')");
				punto.style.cursor="pointer";
				grafico.appendChild(punto);
			}
			
			graficoImg.appendChild(grafico);
		}
		
		function mostrar(id){document.getElementById(id).style.display = "initial";}
		
		function ocultar(id){document.getElementById(id).style.display = "none";}
		
		var ventas = [<%
			HttpSession mySession = request.getSession(false);
			Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
			ArrayList<Factura> facturas = ((ArrayList<Factura>)new FacturaNegImpl().ListarTodas(usuario));
			for(int i=0; i<facturas.size(); i++){
			ArrayList<DetalleFactura> detalles = ((ArrayList<DetalleFactura>)facturas.get(i).getDetalles());
				for(int j=0; j<detalles.size(); j++){%>
				[<%=facturas.get(i).getId()%>,
				<%=facturas.get(i).getFecha().getDia()%>,
				<%=facturas.get(i).getFecha().getMes()%>,
				<%=facturas.get(i).getFecha().getAño()%>,
				<%=detalles.get(j).getCantidad()%>,
				<%=detalles.get(j).getProducto().getId()%>,
				<%=detalles.get(j).getPrecioUnitario()%>]
				<%}
				if(i+1 < facturas.size()){%>
				<%=","%>
				<%}
			}%>
		];	
		
		function contarDigitos(value){
			var cant = 0;
			while (value) {
			   	cant++;
			    value = Math.floor(value / 10);
			}
			return cant;
		}
		
		
		function crearGraficoMes(){
			//PERIODO
			var fechasMes = [1,2,3,4,5,6,7,8,9,10,11,12];
			var fecha = new Date();
			var A = fechasMes.slice(fecha.getMonth()+1,fechasMes.length);
			var B = fechasMes.slice(0,fecha.getMonth()+1);
			fechasMes = A.concat(B)
			var fechas = new Array(12)
			for(var i=0; i<12; i++){
				if(i+1>=fechasMes[i]){
					fechas[i] = [fecha.getYear() + 1900,fechasMes[i]];
				}else{
					fechas[i] = [(fecha.getYear()-1) + 1900,fechasMes[i]];
				}
			}
			//VARIABLES
			var grafico1Y = [0,10,20,30,40,50,60,70,80,90,100];
			var grafico1X = crearTablaX(2);
			var valores = crearValores(fechas);
			max = Math.ceil(max/((contarDigitos(max)-1)*10))*((contarDigitos(max)-1)*10);
			var unidad = Math.ceil(max/(grafico1Y.length-1));
			for(var i=0; i<grafico1Y.length; i++)grafico1Y[i] = i*unidad;
			var id = "tablaGraficoMes";
			max = grafico1Y[grafico1Y.length - 1];
			crearCuadricula(id,tamX,tamY,grafico1X,grafico1Y,"Mes","Cantidad")
			dibujarGrafico("MesTodo",id,'#8AC6FF',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,valores,max,"Mes","Cantidad",grafico1X,grafico1Y)
			dibujarGrafico("MesCuaderno",id,'#FFAB5E',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,cuadernos,max,"Mes","Cantidad",grafico1X,grafico1Y)
			dibujarGrafico("MesAgenda",id,'#6CFF9D',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,agendas,max,"Mes","Cantidad",grafico1X,grafico1Y)
			dibujarGrafico("MesCalendario",id,'#FEFF47',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,calendarios,max,"Mes","Cantidad",grafico1X,grafico1Y)
			dibujarGrafico("MesTarjeta",id,'#CF7BFF',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,tarjetas,max,"Mes","Cantidad",grafico1X,grafico1Y)
			VerMes("MesTodo",'#8AC6FF',"btMesTodo")		
		}
		
		function crearTablaX(op){
			var fecha = new Date();
			if(op==1){
				var graficoX = ['Lun','Mar','Mie','Jue','Vie','Sab','Dom'];
				var A = graficoX.slice(fecha.getDay(),graficoX.length);
				var B = graficoX.slice(0,fecha.getDay());
				return A.concat(B)
			}
			if(op==2){
				var graficoX =['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
				var A = graficoX.slice(fecha.getMonth()+1,graficoX.length);
				var B = graficoX.slice(0,fecha.getMonth()+1);
				return A.concat(B)
			}
		}
		
		var tamX = 575;
		var tamY =305;
		var max = 10;
		
		var valores, cuadernos, agendas, calendarios,
		tarjetas;
		function crearValores(fechas){
			valores = new Array(fechas.length);
			cuadernos = new Array(fechas.length);
			agendas = new Array(fechas.length);
			calendarios = new Array(fechas.length);
			tarjetas = new Array(fechas.length);
			for(var j=0; j<fechas.length; j++){
				valores[j]=0;
				cuadernos[j]=0;
				agendas[j]=0;
				calendarios[j]=0;
				tarjetas[j]=0;
			}
			for(var j=0; j<ventas.length; j++){	
				for(var i=0; i<fechas.length; i++){
					if(fechas[i][0]==ventas[j][3] && fechas[i][1]==ventas[j][2] 
					&& (fechas[0].length == 2 || fechas[i][2] == ventas[j][1])){
						
						valores[i] += ventas[j][4]; 
						if(ventas[j][5] == 1)cuadernos[i] += ventas[j][4];
						if(ventas[j][5] == 2)agendas[i] += ventas[j][4];
						if(ventas[j][5] == 3)calendarios[i] += ventas[j][4];
						if(ventas[j][5] == 4)tarjetas[i] += ventas[j][4];
						if(valores[i]>max)max=valores[i];
					}
				}
			}
			return valores;
		}
		
		function crearGraficoDia(){
			//PERIODO
			var fechas = new Array(7);
			for(var i=0; i<7;i++){
				var fecha = new Date(new Date().getTime() - (1000*60*60*24*(i)));
				fechas[i] = [fecha.getYear()+1900,fecha.getMonth()+1,fecha.getDate()];
			}
			//VARIABLES
			var grafico1Y = [0,10,20,30,40,50,60,70,80,90,100];
			var grafico1X = crearTablaX(1);
			var valores = crearValores(fechas);
			max = Math.ceil(max/((contarDigitos(max)-1)*10))*((contarDigitos(max)-1)*10);
			var unidad = Math.ceil(max/(grafico1Y.length-1));
			for(var i=0; i<grafico1Y.length; i++)grafico1Y[i] = i*unidad;
			var id = "tablaGraficoDia";
			max = grafico1Y[grafico1Y.length - 1];
			crearCuadricula(id,tamX,tamY,grafico1X,grafico1Y,"Dia","Cantidad")
			dibujarGrafico("DiaTodo",id,'#8AC6FF',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,valores,max,"Dia","Cantidad",grafico1X,grafico1Y)
			dibujarGrafico("DiaCuaderno",id,'#FFAB5E',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,cuadernos,max,"Dia","Cantidad",grafico1X,grafico1Y)
			dibujarGrafico("DiaAgenda",id,'#6CFF9D',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,agendas,max,"Dia","Cantidad",grafico1X,grafico1Y)
			dibujarGrafico("DiaCalendario",id,'#FEFF47',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,calendarios,max,"Dia","Cantidad",grafico1X,grafico1Y)
			dibujarGrafico("DiaTarjeta",id,'#CF7BFF',grafico1X.length-1,grafico1Y.length-1,tamX,tamY,tarjetas,max,"Dia","Cantidad",grafico1X,grafico1Y)
			VerDia("DiaTodo",'#8AC6FF',"btDiaTodo")
		}
		crearGraficoDia();
		crearGraficoMes();
		
		<%listaProductos = new ProductoNegImpl().ObtenerMasVendidos("dia");%>
	</script>
    <script>
    	document.getElementById("nombre").style.height=(document.documentElement.clientHeight-50)+"px";
		document.getElementById("nombre").style.lineHeight=(document.documentElement.clientHeight-50)+"px";
    
	    function mostrarProductosDia()
		{
			<%listaProductos = new ProductoNegImpl().ObtenerMasVendidos("dia");%>
				
			document.getElementById('visorProductos').innerHTML = '';
			
			<%if(listaProductos.size() != 0){%>
			
			<%for(int i=0; i<listaProductos.size(); i++){%>
			
			var divProductoItem = document.createElement("div");
	        divProductoItem.setAttribute("id","producto-item" + <%=i%>);
			divProductoItem.setAttribute("class","producto-item");
			document.getElementById('visorProductos').appendChild(divProductoItem);
			
			var divPosicion = document.createElement("div");
			divPosicion.setAttribute("id","posicion" + <%=i%>);
			divPosicion.setAttribute("class","posicion");
			document.getElementById('producto-item' + <%=i%>).appendChild(divPosicion);
			
			var divCirculo = document.createElement("div");
			divCirculo.setAttribute("id","circulo" + <%=i%>);
			divCirculo.setAttribute("class","circulo");
			divCirculo.innerHTML = <%=i + 1%>;
			document.getElementById('posicion' + <%=i%>).appendChild(divCirculo);
			
			var divContenedorImagenProducto = document.createElement("div");
			divContenedorImagenProducto.setAttribute("id","contenedor-imagen-producto" + <%=i%>);
			divContenedorImagenProducto.setAttribute("class","contenedor-imagen-producto");
			document.getElementById('producto-item' + <%=i%>).appendChild(divContenedorImagenProducto);
			
			var ImagenProducto = document.createElement("img");
			ImagenProducto.setAttribute("id","imagen-producto" + <%=i%>);
			ImagenProducto.setAttribute("src","./imgs/perfil/<%=listaProductos.get(i).getUrlImagen()%>");
			ImagenProducto.setAttribute("class","imagen-producto");
			document.getElementById('contenedor-imagen-producto' + <%=i%>).appendChild(ImagenProducto);
			
			var divContenedorNombreProducto = document.createElement("div");
			divContenedorNombreProducto.setAttribute("id","contenedor-nombre-producto" + <%=i%>);
			divContenedorNombreProducto.setAttribute("class","contenedor-nombre-producto");
			document.getElementById('producto-item' + <%=i%>).appendChild(divContenedorNombreProducto);
			
			var NombreProducto = document.createElement("a");
			NombreProducto.setAttribute("id","nombre-producto" + <%=i%>);
			NombreProducto.setAttribute("href","Producto.jsp?idProducto=<%=listaProductos.get(i).getId()%>");
			NombreProducto.setAttribute("class","nombre-producto");
			NombreProducto.innerHTML = "<%=listaProductos.get(i).getNombre()%>";
			document.getElementById('contenedor-nombre-producto' + <%=i%>).appendChild(NombreProducto);
			
			var ContenedorCantidad = document.createElement("div");
			ContenedorCantidad.setAttribute("id","contenedor-cantidad" + <%=i%>);
			ContenedorCantidad.setAttribute("class","contenedor-cantidad");
			ContenedorCantidad.innerHTML = "<%=listaProductos.get(i).getStock()%>";
			document.getElementById('producto-item' + <%=i%>).appendChild(ContenedorCantidad);
			
			<%}%>
			
			<%}%>
			
			document.getElementById("i1").className = "item-seleccionado";
			document.getElementById("i2").className = "item-no-seleccionado";
			document.getElementById("i3").className = "item-no-seleccionado";
		}
        
        mostrarProductosDia();
        
        function mostrarProductosSemana()
		{
			<%listaProductos = new ProductoNegImpl().ObtenerMasVendidos("semana");%>
				
			document.getElementById('visorProductos').innerHTML = '';
			
			<%if(listaProductos.size() != 0){%>
			
			<%for(int i=0; i<listaProductos.size(); i++){%>
			
			var divProductoItem = document.createElement("div");
	        divProductoItem.setAttribute("id","producto-item" + <%=i%>);
			divProductoItem.setAttribute("class","producto-item");
			document.getElementById('visorProductos').appendChild(divProductoItem);
			
			var divPosicion = document.createElement("div");
			divPosicion.setAttribute("id","posicion" + <%=i%>);
			divPosicion.setAttribute("class","posicion");
			document.getElementById('producto-item' + <%=i%>).appendChild(divPosicion);
			
			var divCirculo = document.createElement("div");
			divCirculo.setAttribute("id","circulo" + <%=i%>);
			divCirculo.setAttribute("class","circulo");
			divCirculo.innerHTML = <%=i + 1%>;
			document.getElementById('posicion' + <%=i%>).appendChild(divCirculo);
			
			var divContenedorImagenProducto = document.createElement("div");
			divContenedorImagenProducto.setAttribute("id","contenedor-imagen-producto" + <%=i%>);
			divContenedorImagenProducto.setAttribute("class","contenedor-imagen-producto");
			document.getElementById('producto-item' + <%=i%>).appendChild(divContenedorImagenProducto);
			
			var ImagenProducto = document.createElement("img");
			ImagenProducto.setAttribute("id","imagen-producto" + <%=i%>);
			ImagenProducto.setAttribute("src","./imgs/perfil/<%=listaProductos.get(i).getUrlImagen()%>");
			ImagenProducto.setAttribute("class","imagen-producto");
			document.getElementById('contenedor-imagen-producto' + <%=i%>).appendChild(ImagenProducto);
			
			var divContenedorNombreProducto = document.createElement("div");
			divContenedorNombreProducto.setAttribute("id","contenedor-nombre-producto" + <%=i%>);
			divContenedorNombreProducto.setAttribute("class","contenedor-nombre-producto");
			document.getElementById('producto-item' + <%=i%>).appendChild(divContenedorNombreProducto);
			
			var NombreProducto = document.createElement("a");
			NombreProducto.setAttribute("id","nombre-producto" + <%=i%>);
			NombreProducto.setAttribute("href","Producto.jsp?idProducto=<%=listaProductos.get(i).getId()%>");
			NombreProducto.setAttribute("class","nombre-producto");
			NombreProducto.innerHTML = "<%=listaProductos.get(i).getNombre()%>";
			document.getElementById('contenedor-nombre-producto' + <%=i%>).appendChild(NombreProducto);
			
			var ContenedorCantidad = document.createElement("div");
			ContenedorCantidad.setAttribute("id","contenedor-cantidad" + <%=i%>);
			ContenedorCantidad.setAttribute("class","contenedor-cantidad");
			ContenedorCantidad.innerHTML = "<%=listaProductos.get(i).getStock()%>";
			document.getElementById('producto-item' + <%=i%>).appendChild(ContenedorCantidad);
			
			<%}%>
			
			<%}%>
			
			
			
			document.getElementById("i1").className = "item-no-seleccionado";
			document.getElementById("i2").className = "item-seleccionado";
			document.getElementById("i3").className = "item-no-seleccionado";
		}
        
        function mostrarProductosMes()
		{
			<%listaProductos = new ProductoNegImpl().ObtenerMasVendidos("mes");%>
				
			document.getElementById('visorProductos').innerHTML = '';
			
			<%if(listaProductos.size() != 0){%>
			
			<%for(int i=0; i<listaProductos.size(); i++){%>
			
			var divProductoItem = document.createElement("div");
	        divProductoItem.setAttribute("id","producto-item" + <%=i%>);
			divProductoItem.setAttribute("class","producto-item");
			document.getElementById('visorProductos').appendChild(divProductoItem);
			
			var divPosicion = document.createElement("div");
			divPosicion.setAttribute("id","posicion" + <%=i%>);
			divPosicion.setAttribute("class","posicion");
			document.getElementById('producto-item' + <%=i%>).appendChild(divPosicion);
			
			var divCirculo = document.createElement("div");
			divCirculo.setAttribute("id","circulo" + <%=i%>);
			divCirculo.setAttribute("class","circulo");
			divCirculo.innerHTML = <%=i + 1%>;
			document.getElementById('posicion' + <%=i%>).appendChild(divCirculo);
			
			var divContenedorImagenProducto = document.createElement("div");
			divContenedorImagenProducto.setAttribute("id","contenedor-imagen-producto" + <%=i%>);
			divContenedorImagenProducto.setAttribute("class","contenedor-imagen-producto");
			document.getElementById('producto-item' + <%=i%>).appendChild(divContenedorImagenProducto);
			
			var ImagenProducto = document.createElement("img");
			ImagenProducto.setAttribute("id","imagen-producto" + <%=i%>);
			ImagenProducto.setAttribute("src","./imgs/perfil/<%=listaProductos.get(i).getUrlImagen()%>");
			ImagenProducto.setAttribute("class","imagen-producto");
			document.getElementById('contenedor-imagen-producto' + <%=i%>).appendChild(ImagenProducto);
			
			var divContenedorNombreProducto = document.createElement("div");
			divContenedorNombreProducto.setAttribute("id","contenedor-nombre-producto" + <%=i%>);
			divContenedorNombreProducto.setAttribute("class","contenedor-nombre-producto");
			document.getElementById('producto-item' + <%=i%>).appendChild(divContenedorNombreProducto);
			
			var NombreProducto = document.createElement("a");
			NombreProducto.setAttribute("id","nombre-producto" + <%=i%>);
			NombreProducto.setAttribute("href","Producto.jsp?idProducto=<%=listaProductos.get(i).getId()%>");
			NombreProducto.setAttribute("class","nombre-producto");
			NombreProducto.innerHTML = "<%=listaProductos.get(i).getNombre()%>";
			document.getElementById('contenedor-nombre-producto' + <%=i%>).appendChild(NombreProducto);
			
			var ContenedorCantidad = document.createElement("div");
			ContenedorCantidad.setAttribute("id","contenedor-cantidad" + <%=i%>);
			ContenedorCantidad.setAttribute("class","contenedor-cantidad");
			ContenedorCantidad.innerHTML = "<%=listaProductos.get(i).getStock()%>";
			document.getElementById('producto-item' + <%=i%>).appendChild(ContenedorCantidad);
			
			<%}%>
			
			<%}%>
			
			document.getElementById("i1").className = "item-no-seleccionado";
			document.getElementById("i2").className = "item-no-seleccionado";
			document.getElementById("i3").className = "item-seleccionado";
		}
        
        function obtenerCantidadVentasDia()
        {
        	document.getElementById("cantidadVentas").innerHTML = <%=new FacturaNegImpl().ObtenerCantidadVentas("dia")%>
        
        	document.getElementById("i4").className = "item-seleccionado";
			document.getElementById("i5").className = "item-no-seleccionado";
			document.getElementById("i6").className = "item-no-seleccionado";
        }
        
        //obtenerCantidadVentasDia();
        
        function obtenerCantidadVentasSemana()
        {
        	document.getElementById("cantidadVentas").innerHTML = <%=new FacturaNegImpl().ObtenerCantidadVentas("semana")%>
        	
        	document.getElementById("i4").className = "item-no-seleccionado";
			document.getElementById("i5").className = "item-seleccionado";
			document.getElementById("i6").className = "item-no-seleccionado";
        }
        
        function obtenerCantidadVentasMes()
        {
        	document.getElementById("cantidadVentas").innerHTML = <%=new FacturaNegImpl().ObtenerCantidadVentas("mes")%>
        
        	document.getElementById("i4").className = "item-no-seleccionado";
			document.getElementById("i5").className = "item-no-seleccionado";
			document.getElementById("i6").className = "item-seleccionado";
        }
		
        var barChartData = {
    			labels: [],
    			datasets: [{
    				label: 'Pesos',
    				backgroundColor: 'rgb(13, 145, 197 )',
    				borderColor: 'rgb(13, 145, 197 )',
    				borderWidth: 1,
    				data: [0]
    			}]
    		};
    		
    		
    			var ctx = document.getElementById('canvas').getContext('2d');
    			window.myBar = new Chart(ctx,{
    				type: 'bar',
    				data: barChartData,
    				options: {
    					responsive: true,
    					legend: {
    						position: 'top',
    					},
    					title: {
    						display: false,
    						text: 'Chart.js Bar Chart'
    					}
    				}
    			});
    		
    		
    		function obtenerFacturacionDia()
    		{
    			<%//listaFacturas = new FacturaNegImpl().ObtenerFacturacion("dia");%>
    			
    			//PERIODO
    			var fechas = new Array(7);
    			for(var i=0; i<7;i++){
    				var fecha = new Date(new Date().getTime() - (1000*60*60*24*(i)));
    				fechas[i] = [fecha.getYear()+1900,fecha.getMonth()+1,fecha.getDate()];
    			}
    			//VARIABLES
    			var grafico1X = crearTablaX(1);
    			var valores = crearValores(fechas);

    			barChartData.labels = grafico1X;
    			barChartData.datasets[0].data = valores;
    			window.myBar.update();
    			
    			document.getElementById("i7").className = "item-seleccionado";
    			document.getElementById("i8").className = "item-no-seleccionado";
    			document.getElementById("i9").className = "item-no-seleccionado";
    		}
    		
    		obtenerFacturacionDia();
    		
    		function obtenerFacturacionSemana()
    		{
    			barChartData.labels = [];
    			window.myBar.update();
    			
    			<%listaFacturas = new FacturaNegImpl().ObtenerFacturacion("semana");%>
    			
    			<%if(listaFacturas.size() != 0){%>
    			
    			<%for(int i=0; i<listaFacturas.size(); i++){%>
				barChartData.labels.push('<%=listaFacturas.get(i).getFecha().getDia()%>');
				<%}%>
				
				<%for(int i=0; i<listaFacturas.size(); i++){%>
					barChartData.datasets[0].data[<%=i%>] = <%=listaFacturas.get(i).getMonto()%>;
				<%}%>
				
				window.myBar.update();
				
				barChartData.labels = [];
				window.myBar.update();
				
				<%listaFacturas = new FacturaNegImpl().ObtenerFacturacion("semana");%>
				
				<%for(int i=0; i<listaFacturas.size(); i++){%>
					barChartData.labels.push('<%=listaFacturas.get(i).getFecha().getDia()%>');
				<%}%>
				
				<%for(int i=0; i<listaFacturas.size(); i++){%>
					barChartData.datasets[0].data[<%=i%>] = <%=listaFacturas.get(i).getMonto()%>;
				<%}%>
			
				window.myBar.update();
    			
    			<%}else{%>
    			
    			barChartData.labels = [''];
    			barChartData.datasets[0].data[0] = 0;
    			window.myBar.update();
    			
    			<%}%>
    			
    			document.getElementById("i7").className = "item-no-seleccionado";
    			document.getElementById("i8").className = "item-seleccionado";
    			document.getElementById("i9").className = "item-no-seleccionado";
    		}
    		
    		function obtenerFacturacionMes()
    		{
    			//PERIODO
    			var fechasMes = [1,2,3,4,5,6,7,8,9,10,11,12];
    			var fecha = new Date();
    			var A = fechasMes.slice(fecha.getMonth()+1,fechasMes.length);
    			var B = fechasMes.slice(0,fecha.getMonth()+1);
    			fechasMes = A.concat(B)
    			var fechas = new Array(12)
    			for(var i=0; i<12; i++){
    				if(i+1>=fechasMes[i]){
    					fechas[i] = [fecha.getYear() + 1900,fechasMes[i]];
    				}else{
    					fechas[i] = [(fecha.getYear()-1) + 1900,fechasMes[i]];
    				}
    			}
    			//VARIABLES
    			var grafico1X = crearTablaX(2);
    			var valores = crearValores(fechas);
    		
				barChartData.labels = grafico1X;
    			barChartData.datasets[0].data = null;
    			window.myBar.update();
    			barChartData.labels = grafico1X;
    			barChartData.datasets[0].data = valores;
    			window.myBar.update();
    			
    			document.getElementById("i7").className = "item-no-seleccionado";
    			document.getElementById("i8").className = "item-no-seleccionado";
    			document.getElementById("i9").className = "item-seleccionado";
    		}
		
    </script>
</body>
</html>