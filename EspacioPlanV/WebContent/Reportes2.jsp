<%@page import="entidad.*"%>
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
</head>
<body class="body-reportes">
	<jsp:include page="barraNavegacion.jsp"></jsp:include>
    <jsp:include page="./subHTML/Muro.jsp"><jsp:param name="nombre" value="Reportes" /></jsp:include>
    <div class="ventana-principal" style="height:1650px">
    	<div style="width:100%;float:left;text-align: center;height: 30px;line-height: 30px;font-size: 25px;margin-top: 5px;margin-bottom: 5px;">
    		Año:
    		<select>
    			<option>2019</option>
    		</select>
    		Mes:
    		<select onchange="Mes()" id="mesSel">
    			<option value="0" onchange="Mes(0)">Todos</option>
    			<option value="1" onchange="Mes(1)">Enero</option>
    			<option value="2" onchange="Mes(2)">Febrero</option>
    			<option value="3" onchange="Mes(3)">Marzo</option>
    			<option value="4" onchange="Mes(4)">Abril</option>
    			<option value="5" onchange="Mes(5)">Mayo</option>
    			<option value="6" onchange="Mes(6)">Junio</option>
    			<option value="7" onchange="Mes(7)">Julio</option>
    			<option value="8" onchange="Mes(8)">Agosto</option>
    			<option value="9" onchange="Mes(9)">Septiembre</option>
    			<option value="10" onchange="Mes(10)">Octubre</option>
    			<option value="11" onchange="Mes(11)">Noviembre</option>
    			<option value="12" onchange="Mes(12)">Diciembre</option>
    		</select>
    		<script> 
    		
    		</script>
    		Dia:
    		<select onchange="crearGraficoDia()" id="diasSel">
    			<option value="0">Todos</option>
    		</select>
    	</div>
    	<div style="margin: auto;width: fit-content;height:25px;line-height:25px;text-align:center;">
		      		<div class="btMostrar" onclick="VerDia(0,'#8AC6FF','btDiaTodo')" id="btDiaTodo" style="margin-right: 5px;background-color:#8AC6FF">Todos</div>
		          	<div class="btMostrar" onclick="VerDia(1,'#FFAB5E','btDiaCuadernos')" id="btDiaCuadernos" style="margin-right: 5px;">Cuadernos</div>
		          	<div class="btMostrar" onclick="VerDia(2,'#6CFF9D','btDiaAgendas')" id="btDiaAgendas" style="margin-right: 5px;">Agendas</div>
		          	<div class="btMostrar" onclick="VerDia(3,'#FEFF47','btDiaCalendarios')"id="btDiaCalendarios" style="margin-right: 5px;">Calendarios</div>
		          	<div class="btMostrar" onclick="VerDia(4,'#CF7BFF','btDiaTarjetas')"id="btDiaTarjetas" style="">Tarjetas</div>
		         </div>
		         <script>
		         function VerDia(t,c,bt){
		         		tipo = t;
		         		color = c;
	        			document.getElementById("btDiaTodo").style.backgroundColor="rgb(230,230,230)";
	        			document.getElementById("btDiaCuadernos").style.backgroundColor="rgb(230,230,230)";
		         		document.getElementById("btDiaAgendas").style.backgroundColor="rgb(230,230,230)";
	        			document.getElementById("btDiaCalendarios").style.backgroundColor="rgb(230,230,230)";
	        			document.getElementById("btDiaTarjetas").style.backgroundColor="rgb(230,230,230)";
	        			document.getElementById(bt).style.backgroundColor=c;
	        			crearGraficoDia()
	        		}</script>
    	<div>
    	<div class="barra-titulo" style="margin-top:0">Cantidad de ventas</div>
    	<div style="width: 100%;height: 370px;float: left;text-align: center;">
		    <div id="graficoDia" style="width: 650px;height: 370px;background-color:white;margin: auto;">
		         <div style="margin: auto;width: fit-content;height:25px;line-height:25px;text-align:center;">
		      	 </div>
		      	 <div id="tablaGraficoCantidad" style="position:absolute;width: 825px;height: 250px;background-color:rgba(0,0,0,0);margin-left:50px;float:left;border-style: solid;border-color:rgb(150,150,150);border-width: 0px 0px 1px 1px;">
		       	 </div>
		     </div>
	     </div>
	     <div class="barra-titulo" style="margin-top:0">Facturacion</div>
    	 <div style="width: 100%;height: 370px;float: left;text-align: center;">
		    <div id="graficoDia" style="width: 650px;height: 370px;background-color:white;margin: auto;">
		         <div style="margin: auto;width: fit-content;height:25px;line-height:25px;text-align:center;">
		      	 </div>
		      	 <div id="tablaGraficoFacturacion" style="position:absolute;width: 825px;height: 250px;background-color:rgba(0,0,0,0);margin-left:50px;float:left;border-style: solid;border-color:rgb(150,150,150);border-width: 0px 0px 1px 1px;">
		       	 </div>
		     </div>
	     </div>
	     <div class="barra-titulo" style="margin-top:0">Productos mas vendidos</div>
    	 <div style="width: 100%;height: 370px;float: left;text-align: center;">
		    <div id="graficoDia" style="width: 650px;height: 370px;background-color:white;margin: auto;">
		      	 <div id="topVendidos" style="position:absolute;width: 575px;height: 305px;background-color:rgba(0,0,0,0);margin-left:50px;float:left;border-style: solid;margin-top:25px;border-color:rgb(150,150,150);border-width: 1px;">
		       	 	
		       	 </div>
		     </div>
	      </div>
	     <div class="barra-titulo" style="margin-top:0">Productos que mas ganancias generaron</div>
	      <div style="width: 100%;height: 370px;float: left;text-align: center;">
		    <div id="graficoDia" style="width: 650px;height: 370px;background-color:white;margin: auto;">
		      	 <div id="topFacturacion" style="position:absolute;width: 575px;height: 305px;background-color:rgba(0,0,0,0);margin-left:50px;float:left;border-style: solid;margin-top:25px;border-color:rgb(150,150,150);border-width: 1px;">
		       	 	
		       	 </div>
		     </div>
	      </div>
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
		
		function dibujarGraficoBarra(nombre,id,color,x,y,anchoG,altoG,valores,max,etiquetaX,etiquetaY,ejeX,ejeY){
			var graficoImg = document.getElementById(id);
			var grafico = document.createElement("div");
			grafico.setAttribute("id",nombre);
			var anchoRel = anchoG/x;
			var altoRel = altoG/y;
			
			for(var i=0; i<=x; i++){
				var punto = document.createElement("div");
				var top = ((((max-valores[i])/(max/10))*altoRel));
				punto.style.position = "absolute";
				punto.style.top = top+"px";
				punto.style.height = (altoG-top)+"px";
				punto.style.backgroundColor = color;
				punto.style.left = (((i+1)*anchoRel)-(anchoRel/2-1))+"px";
				punto.style.width = (anchoRel-2)+"px";
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
				<%=detalles.get(j).getProducto().getTipo().getId()%>,
				<%=detalles.get(j).getPrecioUnitario()%>,
				<%=detalles.get(j).getProducto().getId()%>]
				<%}
				if(i+1 < facturas.size()){%>
				<%=","%>
				<%}
			}%>
		];
		
		var productos = [<%
		    ArrayList<Producto> productos = ((ArrayList<Producto>)new ProductoNegImpl().ListarTodos());
			for(int i=0; i<productos.size(); i++){%>
				[<%=productos.get(i).getId()%>,'<%=productos.get(i).getUrlImagen()%>',
					'<%=productos.get(i).getNombre()%>',<%=productos.get(i).getTipo().getId()%>]
				<%if(i+1 < productos.size()){%>
				<%=","%>
			<%}}%>
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
		var maxFac = 10;
		
		var valores, cuadernos, agendas, calendarios,tarjetas;
		var facValores;
		var productoMasVendidos,productosFacturacion;
		var tipo = 0;
		function crearValores(fechas){
			var productosVendidos = new Array(productos.length);
			for(var i=0; i<productosVendidos.length; i++)productosVendidos[i]=[productos[i][0],0,0,productos[i][1],productos[i][2],productos[i][3]];
			valores = new Array(fechas.length);
			facValores = new Array(fechas.length);
			for(var j=0; j<fechas.length; j++){
				valores[j]=0;
				facValores[j]=0;
			}
			for(var j=0; j<ventas.length; j++){	
				for(var i=0; i<fechas.length; i++){
					if(fechas[i][0]==ventas[j][3] && fechas[i][1]==ventas[j][2] 
					&& (fechas[0].length == 2 || fechas[i][2] == ventas[j][1])){
						 
						var estado = false;
						if(tipo==0){
							valores[i] += ventas[j][4];
							facValores[i] += ventas[j][4]*ventas[j][6];
							estado = true;
						}
						if(tipo==1 && ventas[j][5] == 1){
							valores[i] += ventas[j][4];
							facValores[i] += ventas[j][4]*ventas[j][6];
							estado = true;
						}
						if(tipo==2 && ventas[j][5] == 2){
							valores[i] += ventas[j][4];
							facValores[i] += ventas[j][4]*ventas[j][6];
							estado = true;
						}
						if(tipo==3 && ventas[j][5] == 3){
							valores[i] += ventas[j][4];
							facValores[i] += ventas[j][4]*ventas[j][6];
							estado = true;
						}
						if(tipo==4 && ventas[j][5] == 4){
							valores[i] += ventas[j][4];
							facValores[i] += ventas[j][4]*ventas[j][6];
							estado = true;						
						}
						if(valores[i]>max)max=valores[i];
						if(facValores[i]>maxFac)maxFac=facValores[i];
						if(estado == true){
							for(var x=0; x<productosVendidos.length; x++){
								if(ventas[j][7]==productosVendidos[x][0]){
									productosVendidos[x][1] += ventas[j][4];
									productosVendidos[x][2] += ventas[j][4]*ventas[j][6];
									break;
								}
							}
						}
						break;
					}
				}
			}
			productoMasVendidos = [[-1,0,"",""],[-1,0,"",""],[-1,0,"",""],[-1,0,"",""],[-1,0,"",""]];
			productosFacturacion = [[-1,0,"",""],[-1,0,"",""],[-1,0,"",""],[-1,0,"",""],[-1,0,"",""]];
			for(var i=0; i<productosVendidos.length; i++){
				if(productosVendidos[i][1]>productoMasVendidos[0][0]){
					productoMasVendidos[4] = productoMasVendidos[3];
					productoMasVendidos[3] = productoMasVendidos[2];
					productoMasVendidos[2] = productoMasVendidos[1];
					productoMasVendidos[1] = productoMasVendidos[0];
					productoMasVendidos[0] = [productosVendidos[i][1],productosVendidos[i][1],productosVendidos[i][3],productosVendidos[i][4]];
				}else{
					if(productosVendidos[i][1]>productoMasVendidos[1][0]){
						productoMasVendidos[4] = productoMasVendidos[3];
						productoMasVendidos[3] = productoMasVendidos[2];
						productoMasVendidos[2] = productoMasVendidos[1];
						productoMasVendidos[1] = [productosVendidos[i][0],productosVendidos[i][1],productosVendidos[i][3],productosVendidos[i][4]];
					}else{
						if(productosVendidos[i][1]>productoMasVendidos[2][0]){
							productoMasVendidos[4] = productoMasVendidos[3];
							productoMasVendidos[3] = productoMasVendidos[2];
							productoMasVendidos[2] = [productosVendidos[i][0],productosVendidos[i][1],productosVendidos[i][3],productosVendidos[i][4]];
						}else{
							if(productosVendidos[i][1]>productoMasVendidos[3][0]){
								productoMasVendidos[4] = productoMasVendidos[3];
								productoMasVendidos[3] = [productosVendidos[i][0],productosVendidos[i][1],productosVendidos[i][3],productosVendidos[i][4]];
							}else{
								if(productosVendidos[i][1]>productoMasVendidos[4][0]){
									productoMasVendidos[4] = [productosVendidos[i][0],productosVendidos[i][1],productosVendidos[i][3],productosVendidos[i][4]];
								}
							}
						}
					}	
				}
				if(productosVendidos[i][2]>productosFacturacion[0][0]){
					productosFacturacion[4] = productosFacturacion[3];
					productosFacturacion[3] = productosFacturacion[2];
					productosFacturacion[2] = productosFacturacion[1];
					productosFacturacion[1] = productosFacturacion[0];
					productosFacturacion[0] = [productosVendidos[i][2],productosVendidos[i][2],productosVendidos[i][3],productosVendidos[i][4]];
				}else{
					if(productosVendidos[i][2]>productosFacturacion[1][0]){
						productosFacturacion[4] = productosFacturacion[3];
						productosFacturacion[3] = productosFacturacion[2];
						productosFacturacion[2] = productosFacturacion[1];
						productosFacturacion[1] = [productosVendidos[i][2],productosVendidos[i][2],productosVendidos[i][3],productosVendidos[i][4]];
					}else{
						if(productosVendidos[i][2]>productosFacturacion[2][0]){
							productosFacturacion[4] = productosFacturacion[3];
							productosFacturacion[3] = productosFacturacion[2];
							productosFacturacion[2] = [productosVendidos[i][2],productosVendidos[i][2],productosVendidos[i][3],productosVendidos[i][4]];
						}else{
							if(productosVendidos[i][2]>productosFacturacion[3][0]){
								productosFacturacion[4] = productosFacturacion[3];
								productosFacturacion[3] = [productosVendidos[i][2],productosVendidos[i][2],productosVendidos[i][3],productosVendidos[i][4]];
							}else{
								if(productosVendidos[i][2]>productosFacturacion[4][0]){
									productosFacturacion[4] = [productosVendidos[i][2],productosVendidos[i][2],productosVendidos[i][3],productosVendidos[i][4]];
								}
							}
						}
					}	
				}
			}
			
			return valores;
		}
		
		function cargarRanking(id,tabla,color){
			var graficoTabla = document.getElementById(id);
			for(var i=0; i<tabla.length; i++){
				if(tabla[i][1]>0){
				var caja = document.createElement("div");
				caja.style.width = "565px";
				caja.style.height = "55px";
				caja.style.marginLeft = "5px";
			    caja.style.border = "1px solid #E2E2E2";
			    caja.style.backgroundColor = "rgb(240,240,240)";
			    caja.style.borderRadius = "5px";
				caja.style.float = "left";
				caja.style.marginTop = "5px";
				var numero = document.createElement("div");
				numero.style.height = "55px";
				numero.style.width = "5%";
				numero.style.float = "left";
				numero.style.lineHeight = "55px";
				numero.style.textAlign = "center";
				numero.innerText = ""+(i+1);
				caja.appendChild(numero);
				var texto = document.createElement("div");
				texto.style.height = "55px";
				texto.style.width = "50%";
				texto.style.float = "left";
				texto.style.lineHeight = "55px";
				texto.style.textAlign = "left";
				texto.innerText = tabla[i][3];
				
				var img = document.createElement("div");
				img.style.height = "45px";
	
				img.style.marginTop = "5px";
				img.style.width = "45px";
				img.style.backgroundColor = "white";
				texto.style.marginLeft = "1%";
				img.style.float = "left";
				img.style.lineHeight = "55px";
				img.style.textAlign = "center";
				img.style.backgroundSize = "contain";
				img.style.backgroundRepeat = "no-repeat";
				img.style.backgroundPosition = "center";
				img.style.backgroundImage = "url(./imgs/perfil/"+tabla[i][2]+")";
				caja.appendChild(img);caja.appendChild(texto);

				var cantidad = document.createElement("div");
				cantidad.style.color = "white"
				cantidad.style.height = "35px";
				cantidad.style.borderRadius = "5px";
				cantidad.style.marginTop = "10px";
				cantidad.style.marginRight = "10px";
				cantidad.style.width = "20%";
				cantidad.style.float = "right";
				cantidad.style.backgroundColor = color;
				cantidad.style.lineHeight = "35px";
				cantidad.style.textAlign = "center";
				cantidad.innerText = tabla[i][1];
				caja.appendChild(cantidad);
				graficoTabla.appendChild(caja);
			}
			}
		}
		var color = '#8AC6FF';
		function crearGraficoDia(){
			//PERIODO
			var fechas;
			var grafico1X;
			if(document.getElementById("mesSel").value == "0"){
				grafico1X =['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
				fechas = new Array(12);
				for(var i=0; i<12;i++){
					fechas[i] = [2019,i+1];
				}
			}else{

				if(document.getElementById("diasSel").value == "0"){
					grafico1X = new Array(DxM[parseInt(document.getElementById("mesSel").value)-1]);
					fechas = new Array(grafico1X.length);
					for(var x=0; x<grafico1X.length; x++){
						grafico1X[x] = x+1;
						fechas[x] = [2019,parseInt(document.getElementById("mesSel").value),x+1];
					}
				}else{
					fechas = new Array(3)
					grafico1X = new Array(3);
					for(var i=0; i<3;i++){
						var month = ["January","February","March","April","May","June","July","August",
						"September","October","November","December"];
						var m = month[parseInt(document.getElementById("mesSel").value)-1];
						var f = new Date(m+' '+parseInt(document.getElementById("diasSel").value)+', '+2019+' 12:00:00');
	
						var dt = new Date(f - (1000*60*60*24*(i-1)));
						fechas[i] = [dt.getYear()+1900,dt.getMonth()+1,dt.getDate()];
						grafico1X[i] = dt.getDate()
					}
				}		
			}
				
			//VARIABLES
			var grafico1Y = [0,10,20,30,40,50,60,70,80,90,100];
			
			var valores = crearValores(fechas);
			max = Math.ceil(max/((contarDigitos(max)-1)*10))*((contarDigitos(max)-1)*10);
			var unidad = Math.ceil(max/(grafico1Y.length-1));
			for(var i=0; i<grafico1Y.length; i++)grafico1Y[i] = i*unidad;
			var id = "tablaGraficoCantidad";
			max = grafico1Y[grafico1Y.length - 1];
			borrarHijos("tablaGraficoCantidad");
			crearCuadricula(id,tamX,tamY,grafico1X,grafico1Y,"Dia","Cantidad")
			
			dibujarGrafico("DiaTodo",id,color,grafico1X.length-1,grafico1Y.length-1,tamX,tamY,valores,max,"Dia","Cantidad",grafico1X,grafico1Y)
			id = "tablaGraficoFacturacion";
			var espacio = [" "];
			grafico1X = espacio.concat(grafico1X.concat(espacio));
			maxFac = Math.ceil(maxFac/((contarDigitos(maxFac)-1)*10))*((contarDigitos(maxFac)-1)*10);
			var unidad = Math.ceil(maxFac/(grafico1Y.length-1));
			for(var i=0; i<grafico1Y.length; i++)grafico1Y[i] = i*unidad;
			borrarHijos("tablaGraficoFacturacion");
			crearCuadricula(id,tamX,tamY,grafico1X,grafico1Y,"Dia","Cantidad")
			
			dibujarGraficoBarra("DiaFac",id,color,grafico1X.length-1,grafico1Y.length-1,tamX,tamY,facValores,maxFac,"Dia","Cantidad",grafico1X,grafico1Y)
			borrarHijos("topVendidos");
			cargarRanking("topVendidos",productoMasVendidos,color)
			borrarHijos("topFacturacion");
			cargarRanking("topFacturacion",productosFacturacion,color)
		}
		
		function borrarHijos(id){
			var elemento = document.getElementById(id);
			if(elemento.hasChildNodes()){
				while(elemento.childNodes.length >= 1){
					elemento.removeChild(elemento.firstChild)
				}
			}
		}
		crearGraficoDia();
		//crearGraficoMes();
		
		var DxM = [31,28,31,30,31,30,31,31,30,31,30,31];
    		function Mes(){
    			var m = parseInt(document.getElementById("mesSel").value);
    			borrarHijos("diasSel");
    			var todos = document.createElement("option");
    			todos.innerText = "Todos";
    			todos.value = "0";
    			document.getElementById("diasSel").appendChild(todos);
    			for(var i=0; i<DxM[parseInt(document.getElementById("mesSel").value)-1]; i++){
    				var op = document.createElement("option");
        			op.innerText = ""+(i+1);
        			op.value = ""+(i+1);
        			document.getElementById("diasSel").appendChild(op);
    			}
    			crearGraficoDia();
    		}
	</script>
    
</body>
</html>