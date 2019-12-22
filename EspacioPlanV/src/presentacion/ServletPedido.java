package presentacion;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import entidad.Fecha;
import entidad.MensajeChat;
import entidad.Pedido;
import entidad.Usuario;
import negocio.MensajeNeg;
import negocio.PedidoNeg;
import negocioImpl.MensajeNegImpl;
import negocioImpl.PedidoNegImpl;
@WebServlet("/ServletPedido")


public class ServletPedido extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private PedidoNeg pedidoneg = new PedidoNegImpl();
	private MensajeNeg mensajeneg = new MensajeNegImpl();
	
    public ServletPedido() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("btnCancelar") != null)
		{
			int idPedido = Integer.parseInt(request.getParameter("idProducto"));
			
			if(pedidoneg.EliminarPedido(idPedido))
			{
				request.setAttribute("resultadoCancelar", true);
			}
			else 
			{
				request.setAttribute("resultadoCancelar", false);
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("Pedidos.jsp");
			dispatcher.forward(request, response);
		}
		
		if(request.getParameter("btnAgregar") != null)
		{
			HttpSession mySession = request.getSession(false);
	    	Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
			
	    	int idUsuario = usuario.getId();
			int idCategoria = Integer.parseInt(request.getParameter("tipoProducto"));
			String tamProducto = request.getParameter("tamProducto");
			String orientacionProducto = request.getParameter("orientacionProducto");
			String tipoAnillado = request.getParameter("tipoAnillado");
			String descripcionProducto = request.getParameter("descripcionProducto");
			
			if(pedidoneg.AgregarPedido(idUsuario, idCategoria, tamProducto, orientacionProducto, tipoAnillado, descripcionProducto))
			{
				request.setAttribute("resultadoAgregarPedido", true);
			}
			else
			{
				request.setAttribute("resultadoAgregarPedido", false);
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/Pedidos.jsp");
			dispatcher.forward(request, response);
		}
		
		if(request.getParameter("btnGuardar") != null)
		{
			int idPedido = Integer.parseInt(request.getParameter("idPedido"));
			int estado = Integer.parseInt(request.getParameter("txtEstado"));
			int precio = Integer.parseInt(request.getParameter("txtPrecio"));
			
			Pedido pedido = pedidoneg.ObtenerPedido(idPedido);
			pedido.setEstado(estado);
			pedido.setPrecio(precio);
			
			if(pedidoneg.ModificarPedido(pedido))
			{
				request.setAttribute("resultadoModificacion", true);
			}
			else
			{
				request.setAttribute("resultadoModificacion", false);
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/Chat.jsp?idPedido="+idPedido);
			dispatcher.forward(request, response);
		}
		
		if(request.getParameter("btnEnviar") != null)
		{
			int idPedido = Integer.parseInt(request.getParameter("idPedido"));
			int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
			String mensaje = request.getParameter("txtMensaje");
			
			MensajeChat mensajechat = new MensajeChat();
			Usuario usuario = new Usuario();
			usuario.setId(idUsuario);
			Pedido pedido = new Pedido();
			pedido.setId(idPedido);
			pedido.setUsuario(usuario);
			mensajechat.setEstado(1);
			mensajechat.setFecha(new Fecha(10, 10, 10)); //<----------------- OBTENER FECHA DEL SISTEMA
			mensajechat.setMensaje(mensaje);
			mensajechat.setPedido(pedido);
			
			if(mensajeneg.AgregarMensaje(mensajechat, idPedido)) 
			{
				request.setAttribute("resultadoEnviarMensaje", true);
			}
			else
			{
				request.setAttribute("resultadoEnviarMensaje", false);
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/Chat.jsp?idPedido="+idPedido);
			dispatcher.forward(request, response);
		}
		
	}

}
