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
import entidad.Provincia;
import entidad.Usuario;
import negocio.UsuarioNeg;
import negocioImpl.UsuarioNegImpl;

@WebServlet("/ServletCuenta")
public class ServletCuenta extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private UsuarioNeg usuarioneg = new UsuarioNegImpl();
	
    public ServletCuenta() {
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
				case "modificarDatos":
				{
					HttpSession mySession = request.getSession(false);
					Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
					
					usuario.setNombre(request.getParameter("txtNombre"));
					usuario.setApellido(request.getParameter("txtApellido"));
					usuario.setDni(request.getParameter("txtDNI"));
					usuario.setFechaNacimiento(new Fecha(request.getParameter("dateNacimiento"), 1));
					usuario.setTelefono(request.getParameter("txtTelefono"));
					Provincia provincia = new Provincia();
					provincia.setId(Integer.parseInt(request.getParameter("selectProvincia")));
					usuario.setProvincia(provincia);
					usuario.setCiudad(Integer.parseInt(request.getParameter("txtCiudad").toString()));
					usuario.setDireccion(request.getParameter("txtDireccion"));
					
					if(usuarioneg.ModificarUsuario(usuario)) 
					{
						mySession.setAttribute("usuarioLogueado", usuario);
						request.setAttribute("resultadoModificarDatos", true);
					}
					else 
					{
						request.setAttribute("resultadoModificarDatos", false);
					}
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("/miCuenta.jsp");
					dispatcher.forward(request, response);
					break;
				}
				case "cambiarClave":
				{
					HttpSession mySession = request.getSession(false);
					Usuario usuario = (Usuario) mySession.getAttribute("usuarioLogueado");
					
					if(!usuario.getClave().equals(request.getParameter("txtClaveActual")))
					{
						request.setAttribute("errorClaveActual", true);
						RequestDispatcher dispatcher = request.getRequestDispatcher("/CambiarContraseña.jsp");
						dispatcher.forward(request, response);
					}
					else 
					{
						usuario.setClave(request.getParameter("txtClaveNueva"));
						
						if(usuarioneg.ModificarUsuario(usuario)) 
						{
							mySession.setAttribute("usuarioLogueado", usuario);
							request.setAttribute("resultadoCambiarClave", true);
						}
						else 
						{
							request.setAttribute("resultadoCambiarClave", false);
						}
						
						RequestDispatcher dispatcher = request.getRequestDispatcher("/miCuenta.jsp");
						dispatcher.forward(request, response);
					}
					
					break;
				}
				
				default: break;
			}
		}
	}

}
