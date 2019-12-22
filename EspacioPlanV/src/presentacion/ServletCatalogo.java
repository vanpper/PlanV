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

@WebServlet("/ServletCatalogo")
public class ServletCatalogo extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private ProductoNeg productoNeg = new ProductoNegImpl();
    private CarritoNeg carritoNeg = new CarritoNegImpl();
	
    public ServletCatalogo() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession mySession = request.getSession(false);
    	Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
    	int idProducto = Integer.parseInt(request.getParameter("idProducto"));
    	int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
    	
		if(request.getParameter("btAgregar") != null)
		{
			if(usuario != null)
			{
				int cantidad = Integer.parseInt(request.getParameter("cantidad"));
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
			
	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/Catalogo.jsp?idCategoria=" + idCategoria);
			dispatcher.forward(request, response);
		}
		
		if(request.getParameter("btEliminar") != null)
		{
			if(productoNeg.EliminarProducto(idProducto))
			{
				request.setAttribute("resultadoEliminacion", true);
			}
			else 
			{
				request.setAttribute("resultadoEliminacion", false);
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/Catalogo.jsp?idCategoria=" + idCategoria);
			dispatcher.forward(request, response);
			
		}
		
	}

}
