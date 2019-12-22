package datosImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import datos.PedidoDao;
import entidad.Fecha;
import entidad.Pedido;
import entidad.Usuario;

public class PedidoDaoImpl implements PedidoDao{

	@Override
	public boolean AgregarPedido(Pedido pedido) {
		// TODO Auto-generated method stub
		String query = "INSERT INTO pedidos ("
					  	+" IdUsuario,"
					  	+" IdTipoProducto,"
					  	+" Precio,"
					  	+" Fecha,"
					  	+" Estado"
					  	+" ) SELECT ?,?,?,NOW(),?";
		Connection cn = null;
		try{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1,pedido.getUsuario().getId());
			pst.setInt(2,pedido.getTipoProducto().getId());
			pst.setInt(3,pedido.getPrecio());
			//pst.setString(4,pedido.getFecha().toMySQLFormat());
			pst.setInt(4,pedido.getEstado());
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
	public boolean ModificarPedido(Pedido pedido) {
		// TODO Auto-generated method stub
		String query = "UPDATE pedidos SET"
						+" IdUsuario = ?,"
						+" IdTipoProducto = ?,"
						+" Precio = ?,"
						+" Estado = ?"
						+" WHERE idPedido = " + pedido.getId();
		Connection cn = null;
		try{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1,pedido.getUsuario().getId());
			pst.setInt(2,pedido.getTipoProducto().getId());
			pst.setInt(3,pedido.getPrecio());
			pst.setInt(4,pedido.getEstado());
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
	public boolean EliminarPedido(Pedido pedido) {
		// TODO Auto-generated method stub
		String query = "UPDATE pedidos SET"
						+" estado = 4"
						+" WHERE idPedido = " + pedido.getId();
		Connection cn = null;
		try{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
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
	public ArrayList<Pedido> ListarPedidos(Usuario usuario, int categoria, int estado) {
		// TODO Auto-generated method stub
		String query = "SELECT * FROM pedidos";
		if(usuario.getTipo().getId() != 1) query += " WHERE idusuario = " + usuario.getId();
		ArrayList<Pedido> pedidos = null;
		Connection cn = null;
		try{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery();
			pedidos = new ArrayList<Pedido>();
			while(rs.next()) {
				Pedido pedido = new Pedido();
				pedido.setId(rs.getInt("idPedido"));
				pedido.setUsuario(new UsuarioDaoImpl().ObtenerUsuarioXId(rs.getInt("idusuario")));
				pedido.setTipoProducto(new TipoProductoDaoImpl().ObtenerTipoProducto(rs.getInt("idtipoproducto")));
				pedido.setPrecio(rs.getInt("precio"));
				pedido.setFecha(new Fecha(rs.getString("fecha")));
				pedido.setEstado(rs.getInt("estado"));
				if((estado == -1 || estado == pedido.getEstado())&&(categoria == -1 || pedido.getTipoProducto().getId() == categoria)) {
					pedidos.add(pedido);
				}
			}
			
			Conexion.Close(cn);
			return pedidos;
			
		} catch (SQLException e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
		
	}

	public Pedido ObtenerPedido(int id) {
		
		String query = "SELECT * FROM pedidos WHERE idPedido = " + id;
		Connection cn = null;
		
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery();
			rs.next();
			
			Pedido pedido = new Pedido();
			pedido.setId(rs.getInt("idPedido"));
			pedido.setUsuario(new UsuarioDaoImpl().ObtenerUsuarioXId(rs.getInt("idusuario")));
			pedido.setTipoProducto(new TipoProductoDaoImpl().ObtenerTipoProducto(rs.getInt("idtipoproducto")));
			pedido.setPrecio(rs.getInt("precio"));
			pedido.setFecha(new Fecha(rs.getString("fecha")));
			pedido.setEstado(rs.getInt("estado"));
		
			Conexion.Close(cn);
			return pedido;
			
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}

	@Override
	public Pedido ObtenerUltimoPedido(Usuario usuario) {

		String query = "SELECT * FROM pedidos WHERE idUsuario = " + usuario.getId() + " ORDER BY IdPedido DESC LIMIT 1";
		Connection cn = null;
		
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery();
			rs.next();
			
			Pedido pedido = new Pedido();
			pedido.setId(rs.getInt("idPedido"));
			pedido.setUsuario(new UsuarioDaoImpl().ObtenerUsuarioXId(rs.getInt("idusuario")));
			pedido.setTipoProducto(new TipoProductoDaoImpl().ObtenerTipoProducto(rs.getInt("idtipoproducto")));
			pedido.setPrecio(rs.getInt("precio"));
			pedido.setFecha(new Fecha(rs.getString("fecha")));
			pedido.setEstado(rs.getInt("estado"));
			
			Conexion.Close(cn);
			return pedido;
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
		
	}

}
