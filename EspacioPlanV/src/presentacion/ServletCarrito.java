package presentacion;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import entidad.Usuario;
import negocio.CarritoNeg;
import negocioImpl.CarritoNegImpl;
@WebServlet("/ServletCarrito")

public class ServletCarrito extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private CarritoNeg carritoNeg = new CarritoNegImpl();
    
	public ServletCarrito() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("Param") != null)
		{
			String opcion = request.getParameter("Param").toString();
			HttpSession mySession = request.getSession(false);
			Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
			
				if(request.getParameter("btnEliminar") != null)
				{
			    	int idProducto = Integer.parseInt(request.getParameter("idProducto").toString());
			    	
					if(usuario != null)
					{
						if(carritoNeg.EliminarProducto(usuario, idProducto)) 
						{
							request.setAttribute("resultadoEliminarProductoCarrito", true);
						}
						else 
						{
							request.setAttribute("resultadoEliminarProductoCarrito", false);
						}
					}
					else 
					{
						request.setAttribute("resultadoEliminarProductoCarrito", false);
					}
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("/Carrito.jsp");
					dispatcher.forward(request, response);
				}
				if(request.getParameter("btnComprar") != null || request.getParameter("btnGuardar") != null) {
					int total = Integer.parseInt(request.getParameter("total").toString());
					for(int i=0; i<total; i++) {
						int id = Integer.parseInt(request.getParameter("id"+i));
						int cant = Integer.parseInt(request.getParameter("txtCantidad"+i));
						carritoNeg.ModificarProducto(usuario,id,cant);
					}
				}
				if(request.getParameter("btnGuardar") != null)
				{
					RequestDispatcher dispatcher = request.getRequestDispatcher("/Carrito.jsp");
					dispatcher.forward(request, response);
				}
				if(request.getParameter("btnComprar") != null)
				{
					
					
					
					if(usuario != null)
			    	{	
						if(carritoNeg.ComprarCarrito(usuario)) 
						{
							request.setAttribute("resultadoCompraCarrito", true);
						}
						else 
						{
							request.setAttribute("resultadoCompraCarrito", false);
						}
			    	}
					else 
					{
						request.setAttribute("resultadoCompraCarrito", false);
					}
			    	
					RequestDispatcher dispatcher = request.getRequestDispatcher("/Registro.jsp");
					dispatcher.forward(request, response);
				}
				
			
		}
	}

}
