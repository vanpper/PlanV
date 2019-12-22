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
import negocio.UsuarioNeg;
import negocioImpl.UsuarioNegImpl;
@WebServlet("/ServletLogin")

public class ServletLogin extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private UsuarioNeg usuarioNeg = new UsuarioNegImpl(); 
	
    public ServletLogin() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("Param") != null)
		{
			String opcion = request.getParameter("Param");
			
			switch(opcion)
			{
				case "desloguearse":
				{
					HttpSession mySession = request.getSession(false);
					mySession.setAttribute("usuarioLogueado", null);
					
					request.setAttribute("resultadoLogout", true);
					RequestDispatcher dispatcher = request.getRequestDispatcher("/Home.jsp");
					dispatcher.forward(request, response);
					
					break;
				}
				
				default: break;
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("Param") != null)
		{
			String opcion = request.getParameter("Param");
			
			switch(opcion)
			{
				case "loguearse":
				{
					String email = request.getParameter("txtEmail");
					String clave = request.getParameter("txtClave");
					
					Usuario usuario = usuarioNeg.ObtenerUsuarioXMail(email.trim(), clave.trim());
					
					if(usuario != null)
					{
						HttpSession mySession = request.getSession(true);
						mySession.setAttribute("usuarioLogueado", usuario);
						
						request.setAttribute("loginResultado", true);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/Home.jsp");
						dispatcher.forward(request, response);
					}
					else
					{
						request.setAttribute("loginResultado", false);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
						dispatcher.forward(request, response);
					}
					
					break;
				}
				
				default: break;
			}
		}
	}

}
