package presentacion;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entidad.Fecha;
import entidad.Provincia;
import entidad.TipoUsuario;
import entidad.Usuario;
import negocio.ProvinciaNeg;
import negocio.UsuarioNeg;
import negocioImpl.ProvinciaNegImpl;
import negocioImpl.UsuarioNegImpl;
@WebServlet("/ServletRegistrarse")

public class ServletRegistrarse extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private ProvinciaNeg provinciaNeg = new ProvinciaNegImpl();
	private UsuarioNeg usuarioNeg = new UsuarioNegImpl();
    
    public ServletRegistrarse() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("btnCrearCuenta") != null)
		{
			Usuario usuario = new Usuario();
			usuario.setNombre(request.getParameter("txtNombre").toString());
			usuario.setApellido(request.getParameter("txtApellido").toString());
			usuario.setDni(request.getParameter("txtDNI").toString());
			usuario.setFechaNacimiento(new Fecha(request.getParameter("dateNacimiento").toString(), 1));
			usuario.setTelefono(request.getParameter("txtTelefono").toString());
			Provincia provincia = provinciaNeg.Obtener(Integer.parseInt(request.getParameter("selectProvincia").toString()));
			usuario.setProvincia(provincia);
			usuario.setCiudad(Integer.parseInt(request.getParameter("txtCiudad").toString()));
			usuario.setDireccion(request.getParameter("txtDireccion").toString());
			usuario.setMail(request.getParameter("txtEmail").toString());
			usuario.setClave(request.getParameter("txtClave").toString());
			usuario.setEstado(true);
			usuario.setTipo(new TipoUsuario(2, "Cliente", true));
			
			if(usuarioNeg.AgregarUsuario(usuario))
			{
				request.setAttribute("registroResultado", true);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
				dispatcher.forward(request, response);
			}
			else 
			{
				request.setAttribute("registroResultado", false);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/Registrarse.jsp");
				dispatcher.forward(request, response);
			}
		}
	}
}


