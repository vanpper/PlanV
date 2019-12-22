package datosImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import datos.MensajeDao;
import entidad.Fecha;
import entidad.ImagenMensajeChat;
import entidad.MensajeChat;

public class MensajeDaoImpl implements MensajeDao{

	@Override
	public boolean AgregarMensaje(MensajeChat mensaje, int idPedido) {
		String query = "INSERT INTO chatxpedido ("
			  	+" IdPedido,"
			  	+" IdUsuario,"
			  	+" Mensaje,"
			  	+" Fecha,"
			  	+" Estado"
			  	+" ) SELECT ?,?,?,?,?";
		Connection cn = null;
		try{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1,mensaje.getPedido().getId());
			pst.setInt(2,mensaje.getPedido().getUsuario().getId());
			pst.setString(3,mensaje.getMensaje());
			pst.setString(4,mensaje.getFecha().toMySQLFormat());
			pst.setInt(5,mensaje.getEstado());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}		
	}

	@Override
	public boolean ModificarMensaje(MensajeChat mensaje, int idPedido) {
		String query = "UPDATE chatxpedido SET"
			  	+" IdPedido = ?,"
			  	+" IdUsuario = ?,"
			  	+" Mensaje = ?,"
			  	+" Fecha = ?,"
			  	+" Estado = ?"
			  	+" WHERE IdChat = ?";
		Connection cn = null;
		try{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1,mensaje.getId());
			pst.setInt(2,idPedido);
			pst.setString(3,mensaje.getMensaje());
			pst.setString(4,mensaje.getFecha().toMySQLFormat());
			pst.setInt(5,mensaje.getEstado());
			pst.setInt(6,mensaje.getId());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}		
	}

	@Override
	public boolean EliminarMensaje(MensajeChat mensaje) {
		// TODO Auto-generated method stub
		String query = "UPDATE chatxpedido SET"
						+" estado = 0"
						+" WHERE idChat = ?";
		Connection cn = null;
		try{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1,mensaje.getId());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}
	}

	@Override
	public ArrayList<MensajeChat> ListarMensajes(int idPedido) {
		
		String query = "SELECT * FROM chatxpedido WHERE idPedido = " + idPedido;
		Connection cn = null;
		ArrayList<MensajeChat> lista = new ArrayList<MensajeChat>();
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery();
			
			while(rs.next()) 
			{
				MensajeChat mensaje = new MensajeChat();
				mensaje.setId(rs.getInt("idchat"));
				mensaje.setPedido(new PedidoDaoImpl().ObtenerPedido(rs.getInt("idpedido")));
				mensaje.setUsuario(new UsuarioDaoImpl().ObtenerUsuarioXId(rs.getInt("idusuario")));
				mensaje.setMensaje(rs.getString("mensaje"));
				mensaje.setFecha(new Fecha(rs.getString("fecha")));
				mensaje.setEstado(rs.getInt("estado"));
				lista.add(mensaje);
			}
			
			Conexion.Close(cn);
			return lista;
			
		} catch (SQLException e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}

	@Override
	public boolean AgregarImagen(MensajeChat mensaje) {
		String query = "INSERT INTO imagenesxchat ("
			  	+" IdChat,"
			  	+" UrlImagen,"
			  	+" estado ) SELECT ?,?,1 ";
		Connection cn = null;
		try{
			cn = Conexion.Open();
			for(int i=0; i<mensaje.CantidadImagenes(); i++) {
				PreparedStatement pst = cn.prepareStatement(query);
				pst.setInt(1,mensaje.getId());
				pst.setString(2,mensaje.getImagen(i).getUrlImagen());
				pst.executeUpdate();
			}
			Conexion.Close(cn);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}	
	}

	@Override
	public void ListarImagenes(MensajeChat mensaje) {
		// TODO Auto-generated method stub
		String query = "SELECT * FROM imagenesxchat"
						+" WHERE idchat = ?";
		Connection cn = null;
		try{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, mensaje.getId());
			ResultSet rs = pst.executeQuery();
			while(rs.next()) {
				mensaje.addImagen(new ImagenMensajeChat(rs.getString("urlimagen"),rs.getBoolean("estado")));
			}
			Conexion.Close(cn);
		} catch (SQLException e) {
			e.printStackTrace();
			Conexion.Close(cn);
		}
	}
	
	public int obtenrUltimoId(String tabla, String nombreId) {
		String query = "SELECT "+nombreId+" FROM "+tabla+" ORDER BY "+nombreId+" DESC";
		Connection cn = null;
		try{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery();
			if(rs.next()) return rs.getInt(nombreId);
			Conexion.Close(cn);
		} catch (SQLException e) {
			e.printStackTrace();
			Conexion.Close(cn);
		}
		return -1;
	}

}
