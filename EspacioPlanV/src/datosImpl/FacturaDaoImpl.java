package datosImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import datos.FacturaDao;
import entidad.Factura;
import entidad.Fecha;
import entidad.Usuario;

public class FacturaDaoImpl implements FacturaDao{

	@Override
	public boolean AgregarFactura(Factura factura) {
		
		String query = "INSERT INTO facturas("
				+ "IdUsuario,"
				+ "Monto,"
				+ "Fecha,"
				+ "Estado) VALUES(?, ?, NOW(), ?)";
		
		Connection cn = null;
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			
			pst.setInt(1, factura.getUsuario().getId());
			pst.setInt(2, factura.getMonto());
			//pst.setString(3, factura.getFecha().toMySQLFormat());
			pst.setBoolean(3, factura.getEstado());
			
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}
	}

	@Override
	public boolean ModificarFactura(Factura factura) {
		
		String query = "UPDATE facturas SET "
				+ "IdUsuario = ?,"
				+ "Monto = ?,"
				+ "Fecha = ?,"
				+ "Estado = ? WHERE IdFactura = ?";
		
		Connection cn = null;
		
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			
			pst.setInt(1, factura.getUsuario().getId());
			pst.setInt(2, factura.getMonto());
			pst.setString(3, factura.getFecha().toMySQLFormat());
			pst.setBoolean(4, factura.getEstado());
			pst.setInt(5, factura.getId());
			
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}
		
	}

	@Override
	public boolean EliminarFactura(Factura factura) {
		String query = "UPDATE facturas SET Estado = 0 WHERE IdFactura = ?";
		Connection cn = null;
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, factura.getId());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}
	}

	@Override
	public Factura ObtenerFactura(int idFactura) {
		
		String query = "SELECT * FROM facturas WHERE IdFactura = ?";
		Connection cn = null;
	
		try 
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, idFactura);
			ResultSet rs = pst.executeQuery(query);
			Factura factura = new Factura();
			if(rs.next()) {
			factura.setId(rs.getInt(1));
			factura.setUsuario(new UsuarioDaoImpl().ObtenerUsuarioXId(rs.getInt("idusuario")));
			factura.setMonto(rs.getInt(3));		
			factura.setFecha(new Fecha(rs.getDate(4)));
			factura.setEstado(rs.getBoolean(5));
			}
			Conexion.Close(cn);
			
			return factura;
		}
		catch (Exception e) 
		{
			Conexion.Close(cn);
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public ArrayList<Factura> ListarTodas(Usuario usuario) {
		
		String query = "SELECT * FROM facturas";
		if(usuario.getTipo().getId() != 1) query += " WHERE idusuario = " + usuario.getId();
		Connection cn = null;
		ArrayList<Factura> lista = new ArrayList<Factura>();
		try 
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			
			while(rs.next()) 
			{
				Factura factura = new Factura();
				factura.setId(rs.getInt(1));
				factura.setUsuario(new UsuarioDaoImpl().ObtenerUsuarioXId(rs.getInt("idusuario")));
				factura.setMonto(rs.getInt(3));		
				factura.setFecha(new Fecha(rs.getString(4), 1));
				factura.setEstado(rs.getBoolean(5));
				lista.add(factura);
			}
			Conexion.Close(cn);
			return lista;
		}
		catch (Exception e) 
		{
			Conexion.Close(cn);
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Factura ObtenerUltimaFactura() {
		
		String query = "SELECT * FROM facturas ORDER BY IdFactura DESC LIMIT 1";
		Connection cn = null;
	
		try 
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			Factura factura = new Factura();
			if(rs.next()) {
			factura.setId(rs.getInt(1));
			factura.setUsuario(new UsuarioDaoImpl().ObtenerUsuarioXId(rs.getInt("idusuario")));
			factura.setMonto(rs.getInt(3));		
			factura.setFecha(new Fecha(rs.getDate(4)));
			factura.setEstado(rs.getBoolean(5));
			}
			Conexion.Close(cn);
			
			return factura;
		}
		catch (Exception e) 
		{
			Conexion.Close(cn);
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public int ObtenerCantidadVentas(String opcion) {
		
		int cantidad = 0;
		Connection cn = null;
		String query = "SELECT count(*) FROM facturas ";
		
		if(opcion.equals("dia")) query += "where fecha = CURRENT_DATE()";
		if(opcion.equals("semana")) query += "where yearweek(fecha) = yearweek(CURRENT_DATE())";
		if(opcion.equals("mes")) query += "where month(fecha) = month(CURRENT_DATE())";
	
		try 
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			rs.next();
			cantidad = rs.getInt(1);
			Conexion.Close(cn);
			return cantidad;
		}
		catch (Exception e) 
		{
			Conexion.Close(cn);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public ArrayList<Factura> ObtenerFacturacion(String opcion) {
		
		Connection cn = null;
		ArrayList<Factura> lista = new ArrayList<Factura>();
		String query = "SELECT Fecha, sum(Monto) FROM facturas ";
		
		if(opcion.equals("dia")) query += "where fecha = CURRENT_DATE() group by Fecha";
		if(opcion.equals("semana")) query += "where yearweek(fecha) = yearweek(CURRENT_DATE()) group by Fecha";
		if(opcion.equals("mes")) query += "where month(fecha) = month(CURRENT_DATE()) group by Fecha";
		
		try 
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			
			while(rs.next()) 
			{
				Factura factura = new Factura();
				factura.setMonto(rs.getInt(2));		
				factura.setFecha(new Fecha(rs.getString(1), 1));
				lista.add(factura);
			}
			Conexion.Close(cn);
			return lista;
		}
		catch (Exception e) 
		{
			Conexion.Close(cn);
			e.printStackTrace();
			return null;
		}
	}
}
