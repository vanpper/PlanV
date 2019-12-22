<div id="nombre" class="muroCatalogo" style="background-image:url('./img/back2.jpg');overflow:hidden;background-size:400px;border-style: solid;border-width: 0px 0px 1px 0px;">
	<div class="cubrirCatalogo" style="background-color:rgba(0,0,0,0)">
   		<label><%=request.getParameter("nombre")%></label>
	</div>
</div>
<script>
function nuevoTam(){
	document.getElementById("nombre").style.transition="all 2s";
	document.getElementById("nombre").style.height="40px";
	document.getElementById("nombre").style.lineHeight="40px";
	document.getElementById("nombre").style.fontSize="30px";
}
setTimeout(nuevoTam,1000);
</script>