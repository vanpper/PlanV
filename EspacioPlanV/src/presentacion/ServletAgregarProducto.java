package presentacion;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entidad.ImagenProducto;
import entidad.Producto;
import entidad.TipoProducto;
import negocio.ImagenesNeg;
import negocioImpl.ImagenesNegImpl;
import negocioImpl.ProductoNegImpl;

/**
 * Servlet implementation class ServletAgregarCarrito
 */
@WebServlet("/ServletAgregarProducto")
@MultipartConfig
public class ServletAgregarProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletAgregarProducto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	    
		//try { 
			ImagenesNeg imagen = new ImagenesNegImpl(); 
			String context = request.getServletContext().getRealPath("imgs");
			Producto producto = new Producto();
			producto.setTipo(new TipoProducto(Integer.parseInt(request.getParameter("tipoProducto")),"","",true));
			producto.setNombre(request.getParameter("nombre"));
			producto.setDescripcion(request.getParameter("descripcion"));
			producto.setPrecio(Integer.parseInt(request.getParameter("precio")));
			producto.setDescuento(Integer.parseInt(request.getParameter("Descuento")));
			producto.setStock(Integer.parseInt(request.getParameter("Stock")));
			producto.setUrlImagen(imagen.guardarImagen(request.getPart("imgPerfilFile"),context,"perfil",new ProductoNegImpl().ObtenerUltimaImagenPerfil()));
			int contador = Integer.parseInt(request.getParameter("contador"));
			int url = new ProductoNegImpl().ObtenerUltimaImagen();
			for(int i=0; i<contador ; i++) {
				if(request.getPart("file"+i) != null) {
					producto.addImagen(new ImagenProducto(imagen.guardarImagen(request.getPart("file"+i),context,"detalle",url+i),true));
				}
			}
			producto.setEstado(true);
			request.setAttribute("resultadoAgregar",new ProductoNegImpl().AgregarProducto(producto));
		/*}catch(Exception e){
			request.setAttribute("resultadoAgregar",false);
		}*/
		RequestDispatcher dispatcher = request.getRequestDispatcher("/Catalogo.jsp?idCategoria=" + Integer.parseInt(request.getParameter("tipoProducto")));
		dispatcher.forward(request, response);
	}

}
