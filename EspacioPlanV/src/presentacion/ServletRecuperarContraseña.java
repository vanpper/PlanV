package presentacion;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import negocio.UsuarioNeg;
import negocioImpl.UsuarioNegImpl;
@WebServlet("/ServletRecuperarContraseña")

public class ServletRecuperarContraseña extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private UsuarioNeg usuarioNeg = new UsuarioNegImpl();
	
    public ServletRecuperarContraseña() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("Param") != null)
		{
			String opcion = request.getParameter("Param");
			
			switch(opcion)
			{
				case "enviarCodigo":
				{
					HttpSession mySession = request.getSession(true);
					mySession.setAttribute("mailRecuperacion", request.getParameter("txtMail"));
					
					String codigo = usuarioNeg.generarCodigo();
					
					if(usuarioNeg.enviarConGMail(request.getParameter("txtMail"), "Codigo de recuperacion", "Su codigo es: " + codigo)) 
					{
						request.setAttribute("codigoRecuperacion", codigo);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/RecuperarContraseña2.jsp");
						dispatcher.forward(request, response);
					}
					else 
					{
						request.setAttribute("resultadoEnviarCodigo", false);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/RecuperarContraseña.jsp");
						dispatcher.forward(request, response);
					}
					
					break;
				}
				case "compararCodigos":
				{
					String codigoGenerado = request.getParameter("codigoGenerado");
					String codigoIngresado = request.getParameter("txtCodigo");
					
					if(codigoGenerado.equals(codigoIngresado))
					{
						RequestDispatcher dispatcher = request.getRequestDispatcher("/RecuperarContraseña3.jsp");
						dispatcher.forward(request, response);
					}
					else
					{
						request.setAttribute("resultadoCompararCodigos", false);
						request.setAttribute("codigoRecuperacion", codigoGenerado);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/RecuperarContraseña2.jsp");
						dispatcher.forward(request, response);
					}
					
					break;
				}
				case "nuevaClave":
				{
					String nuevaClave = request.getParameter("txtClave1");
					String email = request.getParameter("email");
					
					if(usuarioNeg.ModificarClave(email, nuevaClave))
					{
						request.setAttribute("resultadoRecuperacion", true);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
						dispatcher.forward(request, response);
					}
					else
					{
						request.setAttribute("resultadoRecuperacion", false);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/Home.jsp");
						dispatcher.forward(request, response);
					}
					
					break;
				}
				
				default: break;
			}
		}
		
	}

}
