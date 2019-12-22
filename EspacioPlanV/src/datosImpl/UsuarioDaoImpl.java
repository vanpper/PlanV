package datosImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import datos.UsuarioDao;
import entidad.Fecha;
import entidad.Provincia;
import entidad.TipoUsuario;
import entidad.Usuario;

public class UsuarioDaoImpl implements UsuarioDao{
	
	public TipoUsuario ObtenerTipoUsuario(int id) {
		String query = "SELECT * FROM TipoUsuarios WHERE IdTipoUsuario = " + id;
		Connection cn = null;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			TipoUsuario tipo = null;
			ResultSet rs = pst.executeQuery(query);
			if(rs.next()) {
				tipo = new TipoUsuario();
				tipo.setId(rs.getInt("IdTipoUsuario"));
				tipo.setDescripcion(rs.getString("Descripcion"));
				tipo.setEstado(rs.getBoolean("estado"));
			}
			Conexion.Close(cn);
			return tipo;
		}
		catch(Exception e) {
			Conexion.Close(cn);
			e.printStackTrace();
		}
		return null;
	}
	
	public Provincia ObtenerProvincia(int id) {
		String query = "SELECT * FROM Provincia WHERE id = " + id;
		Connection cn = null;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			Provincia provincia = null;
			ResultSet rs = pst.executeQuery(query);
			if(rs.next()) {
				provincia = new Provincia();
				provincia.setId(rs.getInt("id"));
				provincia.setNombre(rs.getString("nombre"));
			}
			Conexion.Close(cn);
			return provincia;
		}
		catch(Exception e) {
			Conexion.Close(cn);
			e.printStackTrace();
		}
		return null;
	}

	public Usuario ObtenerUsuarioXId(int id) {
		String query = "SELECT * FROM usuarios WHERE idusuario = " + id;
		Connection cn = null;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			Usuario usuario = null;
			ResultSet rs = pst.executeQuery(query);
			if(rs.next()) {
				usuario = new Usuario();
				usuario.setId(id);
				usuario.setMail(rs.getString("Mail"));
				usuario.setDni(rs.getString("Dni"));
				usuario.setTipo(this.ObtenerTipoUsuario(rs.getInt("IdTipoUsuario")));
				usuario.setNombre(rs.getString("Nombre"));
				usuario.setApellido(rs.getString("Apellido"));
				usuario.setFechaNacimiento(new Fecha(rs.getString("FechaNacimiento")));
				usuario.setCiudad(rs.getInt("Ciudad"));
				usuario.setDireccion(rs.getString("Direccion"));
				usuario.setTelefono(rs.getString("Telefono"));
				usuario.setProvincia(this.ObtenerProvincia(rs.getInt("IdProvincia")));
				usuario.setClave(rs.getString("Clave"));
				usuario.setEstado(rs.getBoolean("Estado"));
			}
			Conexion.Close(cn);
			return usuario;
		}
		catch(Exception e) {
			Conexion.Close(cn);
			e.printStackTrace();
		}
		return null;
	}

	public Usuario ObtenerUsuarioXMail(String mail, String clave) {
		String query = "SELECT * FROM usuarios WHERE Mail = '" + mail + "' AND Clave = '" + clave + "'";
		Connection cn = null;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			Usuario usuario = null;
			ResultSet rs = pst.executeQuery(query);
			if(rs.next()) {
				usuario = new Usuario();
				usuario.setId(rs.getInt("IdUsuario"));
				usuario.setMail(rs.getString("Mail"));
				usuario.setDni(rs.getString("Dni"));
				usuario.setTipo(this.ObtenerTipoUsuario(rs.getInt("IdTipoUsuario")));
				usuario.setNombre(rs.getString("Nombre"));
				usuario.setApellido(rs.getString("Apellido"));
				
				usuario.setFechaNacimiento(new Fecha(rs.getString("FechaNacimiento")));
				usuario.setCiudad(rs.getInt("Ciudad"));
				usuario.setDireccion(rs.getString("Direccion"));
				usuario.setTelefono(rs.getString("Telefono"));
				usuario.setProvincia(this.ObtenerProvincia(rs.getInt("IdProvincia")));
				usuario.setClave(rs.getString("Clave"));
				usuario.setEstado(rs.getBoolean("Estado"));
			}
			Conexion.Close(cn);
			return usuario;
		}
		catch(Exception e) {
			Conexion.Close(cn);
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public Usuario ObtenerUsuarioXMail(String mail) {
		
		String query = "SELECT * FROM usuarios WHERE Mail = '" + mail + "'";
		Connection cn = null;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			Usuario usuario = null;
			ResultSet rs = pst.executeQuery(query);
			if(rs.next()) {
				usuario = new Usuario();
				usuario.setId(rs.getInt("IdUsuario"));
				usuario.setMail(rs.getString("Mail"));
				usuario.setDni(rs.getString("Dni"));
				usuario.setTipo(this.ObtenerTipoUsuario(rs.getInt("IdTipoUsuario")));
				usuario.setNombre(rs.getString("Nombre"));
				usuario.setApellido(rs.getString("Apellido"));
				usuario.setFechaNacimiento(new Fecha(rs.getString("FechaNacimiento")));
				usuario.setCiudad(rs.getInt("Ciudad"));
				usuario.setDireccion(rs.getString("Direccion"));
				usuario.setTelefono(rs.getString("Telefono"));
				usuario.setProvincia(this.ObtenerProvincia(rs.getInt("IdProvincia")));
				usuario.setClave(rs.getString("Clave"));
				usuario.setEstado(rs.getBoolean("Estado"));
			}
			Conexion.Close(cn);
			return usuario;
		}
		catch(Exception e) {
			Conexion.Close(cn);
			e.printStackTrace();
			return null;
		}
	}

	public String ObtenerClave(String mail) {
		// TODO Auto-generated method stub
		String query = "Select Clave FROM usuarios"
				+ "	WHERE Mail = ?";
		Connection cn = null;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setString(1, mail);
			ResultSet rs = pst.executeQuery();
			if(rs.next()) {
				return rs.getString("Clave");
			}
			Conexion.Close(cn);
		}
		catch(Exception e) {
			Conexion.Close(cn);
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean AgregarUsuario(Usuario usuario) {
		String query = "INSERT INTO usuarios("
						+ "Mail,"
						+ "Dni,"
						+ "IdTipoUsuario,"
						+ "Nombre,"
						+ "Apellido,"
						+ "FechaNacimiento,"
						+ "IdProvincia,"
						+ "Ciudad,"
						+ "Direccion,"
						+ "Telefono,"
						+ "Clave,"
						+ "Estado) VALUES(?,?,?,?,?,\""+usuario.getFechaNacimiento().toMySQLFormat()+"\",?,?,?,?,?,?)";
		Connection cn = null;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setString(1, usuario.getMail());
			pst.setString(2, usuario.getDni());
			pst.setInt(3, usuario.getTipo().getId());
			pst.setString(4, usuario.getNombre());
			pst.setString(5, usuario.getApellido());
			pst.setInt(6, usuario.getProvincia().getId());
			pst.setInt(7, usuario.getCiudad());
			pst.setString(8, usuario.getDireccion());
			pst.setString(9, usuario.getTelefono());
			pst.setString(10, usuario.getClave());
			pst.setBoolean(11, usuario.getEstado());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e) {
			Conexion.Close(cn);
			e.printStackTrace();
			return false;
		}
	}

	public boolean ModificarUsuario(Usuario usuario) {
		// TODO Auto-generated method stub
		String query = "UPDATE usuarios SET "
						+ "Mail = ?,"
						+ "Dni = ?,"
						+ "IdTipoUsuario = ?,"
						+ "Nombre = ?,"
						+ "Apellido = ?,"
						+ "FechaNacimiento = ?,"
						+ "IdProvincia = ?,"
						+ "Ciudad = ?,"
						+ "Direccion = ?,"
						+ "Telefono = ?,"
						+ "Clave = ?,"
						+ "Estado = ? WHERE IdUsuario = " + usuario.getId();
		Connection cn = null;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setString(1, usuario.getMail());
			pst.setString(2, usuario.getDni());
			pst.setInt(3, usuario.getTipo().getId());
			pst.setString(4, usuario.getNombre());
			pst.setString(5, usuario.getApellido());
			pst.setString(6, usuario.getFechaNacimiento().toMySQLFormat());
			pst.setInt(7, usuario.getProvincia().getId());
			pst.setInt(8, usuario.getCiudad());
			pst.setString(9, usuario.getDireccion());
			pst.setString(10, usuario.getTelefono());
			pst.setString(11, usuario.getClave());
			pst.setBoolean(12, usuario.getEstado());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e) {
			Conexion.Close(cn);
			e.printStackTrace();
			return false;
		}
	}

	public boolean ModificarClave(String mail, String claveNueva) {
		// TODO Auto-generated method stub
		String query = "UPDATE usuarios SET Clave = '"+ claveNueva + "' WHERE Mail = '" + mail + "'";
		Connection cn = null;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e) {
			Conexion.Close(cn);
			e.printStackTrace();
			return false;
		}
	}

	

}
