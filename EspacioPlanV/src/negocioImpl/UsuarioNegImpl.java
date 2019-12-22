package negocioImpl;

import datos.UsuarioDao;
import datosImpl.UsuarioDaoImpl;
import entidad.Provincia;
import entidad.TipoUsuario;
import entidad.Usuario;
import negocio.UsuarioNeg;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class UsuarioNegImpl implements UsuarioNeg{

	private UsuarioDao usuarioDao = new UsuarioDaoImpl();
	
	@Override
	public TipoUsuario ObtenerTipoUsuario(int id) {
		return usuarioDao.ObtenerTipoUsuario(id);
	}

	@Override
	public Provincia ObtenerProvincia(int id) {
		return usuarioDao.ObtenerProvincia(id);
	}

	@Override
	public Usuario ObtenerUsuarioXId(int id) {
		return usuarioDao.ObtenerUsuarioXId(id);
	}

	@Override
	public boolean AgregarUsuario(Usuario usuario) {
		return usuarioDao.AgregarUsuario(usuario);
	}

	@Override
	public Usuario ObtenerUsuarioXMail(String mail, String clave) {
		return usuarioDao.ObtenerUsuarioXMail(mail, clave);
	}
	
	@Override
	public Usuario ObtenerUsuarioXMail(String mail) {
		return usuarioDao.ObtenerUsuarioXMail(mail);
	}

	@Override
	public boolean ModificarUsuario(Usuario usuario) {
		return usuarioDao.ModificarUsuario(usuario);
	}

	@Override
	public boolean ModificarClave(String mail, String claveNueva) {
		return usuarioDao.ModificarClave(mail, claveNueva);
	}

	@Override
	public String ObtenerClave(String mail) {
		return usuarioDao.ObtenerClave(mail);
	}
	
	@Override
	public boolean enviarConGMail(String destinatario, String asunto, String cuerpo) {
		
	    String remitente = "planvteam@gmail.com";

	    Properties props = System.getProperties();
	    
	    props.put("mail.smtp.host", "smtp.gmail.com");
	    props.put("mail.smtp.user", remitente);
	    props.put("mail.smtp.clave", "planv1234");
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.starttls.enable", "true");
	    props.put("mail.smtp.port", "587");
	    props.put("mail.smtp.starttls.enable", "true");
	    props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

	    Session session = Session.getDefaultInstance(props);
	    MimeMessage message = new MimeMessage(session);

	    if(usuarioDao.ObtenerClave(destinatario) != null) {
	    try {
	        message.setFrom(new InternetAddress(remitente));
	        message.addRecipients(Message.RecipientType.TO, destinatario);
	        message.setSubject(asunto);
	        message.setText(cuerpo);
	        Transport transport = session.getTransport("smtp");
	        transport.connect("smtp.gmail.com", remitente, "planv1234");
	        transport.sendMessage(message, message.getAllRecipients());
	        transport.close();
	        return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	    }else {
	    	return false;
	    }
	}
	@Override
	public String generarCodigo()
	{
		String codigo = "";
		
		for(int i=0; i<6; i++) 
		{
			int numero = (int)(Math.random()*9+0);
			codigo += numero;
		}
		
		return codigo;
	}

	
}
