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
import negocio.ProductoNeg;
import negocioImpl.CarritoNegImpl;
import negocioImpl.ProductoNegImpl;

@WebServlet("/ServletProducto")
public class ServletProducto extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private ProductoNeg productoNeg = new ProductoNegImpl();
	private CarritoNeg carritoNeg = new CarritoNegImpl();
	
    public ServletProducto() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		if(request.getParameter("btnAccion") != null) 
		{
			String opcion = request.getParameter("btnAccion").toString();
			int idProducto = Integer.parseInt(request.getParameter("idProducto").toString());
			int cantidad = Integer.parseInt(request.getParameter("txtCantidad").toString());
			
			HttpSession mySession = request.getSession(false);
	    	Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
			
			switch(opcion) 
			{
				case "Comprar":
				{	
					if(usuario != null)
			    	{
			    		if(productoNeg.ComprarProducto(usuario.getId(), idProducto, cantidad))
				    	{
				    		request.setAttribute("resultadoCompraProducto", true);
				    	}
				    	else 
				    	{
				    		request.setAttribute("resultadoCompraProducto", false);
				    	}
			    	}
			    	else
			    	{
			    		request.setAttribute("resultadoCompraProducto", false);
			    	}
			    	
			    	RequestDispatcher dispatcher = request.getRequestDispatcher("/Registro.jsp");
					dispatcher.forward(request, response);
					
					break;
				}
				case "Agregar al carrito":
				{
					if(usuario != null)
					{
						if(carritoNeg.AgregarProducto(usuario, idProducto, cantidad))
						{
							request.setAttribute("resultadoAgregarACarrito", true);
						}
						else
						{
							request.setAttribute("resultadoAgregarACarrito", false);
						}
					}
					else 
					{
						request.setAttribute("resultadoAgregarACarrito", false);
					}
					
			    	RequestDispatcher dispatcher = request.getRequestDispatcher("/Carrito.jsp");
					dispatcher.forward(request, response);
					break;
				}
				
				default: break;
			}
		}
	}
}
