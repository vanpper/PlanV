package negocio;

import entidad.Provincia;
import entidad.TipoUsuario;
import entidad.Usuario;

public interface UsuarioNeg {

public abstract TipoUsuario ObtenerTipoUsuario(int id);
	
	public abstract Provincia ObtenerProvincia(int id);

	public abstract Usuario ObtenerUsuarioXId(int id);
	
	public abstract boolean AgregarUsuario(Usuario usuario);
	
	public abstract Usuario ObtenerUsuarioXMail(String mail, String clave);
	
	public abstract Usuario ObtenerUsuarioXMail(String mail);
	
	public abstract boolean ModificarUsuario(Usuario usuario);

	public abstract boolean ModificarClave(String mail, String claveNueva);
	
	public abstract String ObtenerClave(String mail);
	
	public abstract boolean enviarConGMail(String destinatario, String asunto, String cuerpo);
	
	public abstract String generarCodigo();
}
