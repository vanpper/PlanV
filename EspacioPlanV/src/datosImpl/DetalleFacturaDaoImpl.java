package datosImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import datos.DetalleFacturaDao;
import entidad.DetalleFactura;
import entidad.Factura;

public class DetalleFacturaDaoImpl implements DetalleFacturaDao{
	
	@Override
	public boolean AgregarDetalleFactura(Factura factura, DetalleFactura detalle) {
		
		String query = "INSERT INTO detallesfacturas(IdFactura,IdProducto,PrecioUnitario,Cantidad,Estado) VALUES(?, ?, ?, ?, ?)";
		Connection cn = null;
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, factura.getId());
			pst.setInt(2, detalle.getProducto().getId());
			pst.setInt(3, detalle.getPrecioUnitario());
			pst.setInt(4, detalle.getCantidad());
			pst.setBoolean(5, detalle.getEstado());
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
	public boolean ModificarDetalleFactura(Factura factura, DetalleFactura detalle) {
		
		String query = "UPDATE detallesfacturas SET "
				+ "PrecioUnitario = ?, "
				+ "Cantidad = ?, "
				+ "Estado = ? WHERE IdFactura = ? AND IdProducto = ?";
		
		Connection cn = null;
		
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, detalle.getPrecioUnitario());
			pst.setInt(2, detalle.getCantidad());
			pst.setBoolean(3, detalle.getEstado());
			pst.setInt(factura.getId(),detalle.getProducto().getId());
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
	public boolean EliminarDetalleFactura(Factura factura, int idProducto) {
		
		String query = "UPDATE detallesfacturas SET Estado = 0 WHERE IdFactura = ? AND IdProducto = ?";
		
		Connection cn = null;
		
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, factura.getId());
			pst.setInt(2, idProducto);
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e)
		{
			Conexion.Close(cn);
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public ArrayList<DetalleFactura> ObtenerDetalleCompleto(Factura factura) {
		
		String query = "SELECT * FROM detallesfacturas WHERE IdFactura = " + factura.getId();
		ArrayList<DetalleFactura> lista = new ArrayList<DetalleFactura>();
		Connection cn = null;
		
		try 
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			while(rs.next())
			{
				DetalleFactura detalle = new DetalleFactura();
				detalle.setIdfactura(rs.getInt(1));
				detalle.setProducto(new ProductoDaoImpl().ObtenerProducto(rs.getInt("idproducto")));
				detalle.setPrecioUnitario(rs.getInt(3));		
				detalle.setCantidad(rs.getInt(4));
				detalle.setEstado(rs.getBoolean(5));
				lista.add(detalle);
			}
			Conexion.Close(cn);
			return lista;
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}

	@Override
	public ArrayList<DetalleFactura> ObtenerTodos() {
		// TODO Auto-generated method stub
		String query = "SELECT * FROM detallesfacturas";
		ArrayList<DetalleFactura> lista = new ArrayList<DetalleFactura>();
		Connection cn = null;
		
		try 
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			while(rs.next())
			{
				DetalleFactura detalle = new DetalleFactura();
				detalle.setIdfactura(rs.getInt(1));
				detalle.setProducto(new ProductoDaoImpl().ObtenerProducto(rs.getInt("idproducto")));
				detalle.setPrecioUnitario(rs.getInt(3));		
				detalle.setCantidad(rs.getInt(4));
				detalle.setEstado(rs.getBoolean(5));
				lista.add(detalle);
			}
			Conexion.Close(cn);
			return lista;
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}

}
