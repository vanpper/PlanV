package datosImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import datos.ProductoDao;
import datos.TipoProductoDao;
import entidad.Producto;
import entidad.TipoProducto;

public class ProductoDaoImpl implements ProductoDao{

	@Override
	public boolean AgregarProducto(Producto producto) {
		
		Connection cn = null;
		
		String query = "INSERT INTO productos("
				+ "IdTipoProducto,"
				+ "Nombre,"
				+ "Descripcion,"
				+ "Precio,"
				+ "Descuento,"
				+ "Stock,"
				+ "UrlImagen"
				+ ") VALUES(?,?,?,?,?,?,?)";
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, producto.getTipo().getId());
			pst.setString(2, producto.getNombre());
			pst.setString(3, producto.getDescripcion());
			pst.setInt(4, producto.getPrecio());
			pst.setInt(5, producto.getDescuento());
			pst.setInt(6, producto.getStock());
			pst.setString(7, producto.getUrlImagen());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}
	}

	@Override
	public boolean ModificarProducto(Producto producto) {
		
		Connection cn = null;
		
		String query = "UPDATE productos SET "
				+ "IdTipoProducto = ?,"
				+ "Nombre = ?,"
				+ "Descripcion = ?,"
				+ "Precio = ?,"
				+ "Descuento = ?,"
				+ "Stock = ?,"
				+ "UrlImagen = ?,"
				+ "Estado = ?"
				+ " WHERE IdProducto = " + producto.getId();
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, producto.getTipo().getId());
			pst.setString(2, producto.getNombre());
			pst.setString(3, producto.getDescripcion());
			pst.setInt(4, producto.getPrecio());
			pst.setInt(5, producto.getDescuento());
			pst.setInt(6, producto.getStock());
			pst.setString(7, producto.getUrlImagen());
			pst.setBoolean(8, producto.getEstado());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}
	}

	@Override
	public boolean EliminarProducto(Producto producto) {
		Connection cn = null;
		String query = "UPDATE productos SET Estado = 0 WHERE IdProducto = " + producto.getId()+" AND estado = 1 ";
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}
	}

	@Override
	public ArrayList<Producto> ListarTodos(int categoria, int min, int max, String substring) {
		
		Connection cn = null;
		TipoProductoDao tipoDao = new TipoProductoDaoImpl();
		ArrayList<Producto> lista = new ArrayList<Producto>();
		String query = "SELECT * FROM productos WHERE idTipoProducto = "+categoria;
		try {
			cn = Conexion.Open();
			Statement st = cn.createStatement();
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next())
			{
				Producto producto = new Producto();
				producto.setId(rs.getInt(1));
				TipoProducto tipo = tipoDao.ObtenerTipoProducto(rs.getInt(2));
				producto.setTipo(tipo);
				producto.setNombre(rs.getString(3));
				producto.setDescripcion(rs.getString(4));
				producto.setPrecio(rs.getInt(5));
				producto.setDescuento(rs.getInt(6));
				producto.setStock(rs.getInt(7));
				producto.setUrlImagen(rs.getString(8));
				producto.setEstado(rs.getBoolean(9));
				if(producto.getEstado() != false && producto.getStock() > 0) {
					int precio = producto.getPrecio()-(producto.getPrecio()*producto.getDescuento()/100);
					String name = producto.getNombre();
					if(precio >= min && (max == -1 || precio <= max) && name.indexOf(substring) != -1) {
						lista.add(producto);
					}
				}
			}
			Conexion.Close(cn);
			return lista;
		}
		catch (Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}

	@Override
	public Producto ObtenerProducto(int id) {		
		Connection cn = null;
		TipoProductoDao tipoDao = new TipoProductoDaoImpl();
		String query = "SELECT * FROM productos WHERE IdProducto = " + id;
		Producto producto = new Producto();
		
		try {
			cn = Conexion.Open();
			Statement st = cn.createStatement();
			ResultSet rs = st.executeQuery(query);
			rs.next();
			
			producto.setId(rs.getInt(1));
			TipoProducto tipo = tipoDao.ObtenerTipoProducto(rs.getInt(2));
			producto.setTipo(tipo);
			producto.setNombre(rs.getString(3));
			producto.setDescripcion(rs.getString(4));
			producto.setPrecio(rs.getInt(5));
			producto.setDescuento(rs.getInt(6));
			producto.setStock(rs.getInt(7));
			producto.setUrlImagen(rs.getString(8));
			producto.setEstado(rs.getBoolean(9));
			
			Conexion.Close(cn);
			return producto;
		}
		catch (Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}
	
	@Override
	public Producto ObtenerUltimoProducto() {		
		Connection cn = null;
		TipoProductoDao tipoDao = new TipoProductoDaoImpl();
		String query = "SELECT * FROM productos ORDER BY IdProducto DESC LIMIT 1";
		Producto producto = new Producto();
		
		try {
			cn = Conexion.Open();
			Statement st = cn.createStatement();
			ResultSet rs = st.executeQuery(query);
			rs.next();
			
			producto.setId(rs.getInt(1));
			TipoProducto tipo = tipoDao.ObtenerTipoProducto(rs.getInt(2));
			producto.setTipo(tipo);
			producto.setNombre(rs.getString(3));
			producto.setDescripcion(rs.getString(4));
			producto.setPrecio(rs.getInt(5));
			producto.setDescuento(rs.getInt(6));
			producto.setStock(rs.getInt(7));
			producto.setUrlImagen(rs.getString(8));
			producto.setEstado(rs.getBoolean(9));
			
			Conexion.Close(cn);
			return producto;
		}
		catch (Exception e) {
			
			Conexion.Close(cn);
			return null;
		}
	}

	@Override
	public ArrayList<Producto> ListarTodos() {
		Connection cn = null;
		TipoProductoDao tipoDao = new TipoProductoDaoImpl();
		ArrayList<Producto> lista = new ArrayList<Producto>();
		String query = "SELECT * FROM productos";
		try {
			cn = Conexion.Open();
			Statement st = cn.createStatement();
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next())
			{
				Producto producto = new Producto();
				producto.setId(rs.getInt(1));
				TipoProducto tipo = tipoDao.ObtenerTipoProducto(rs.getInt(2));
				producto.setTipo(tipo);
				producto.setNombre(rs.getString(3));
				producto.setDescripcion(rs.getString(4));
				producto.setPrecio(rs.getInt(5));
				producto.setDescuento(rs.getInt(6));
				producto.setStock(rs.getInt(7));
				producto.setUrlImagen(rs.getString(8));
				producto.setEstado(rs.getBoolean(9));
				lista.add(producto);
			}
			
			Conexion.Close(cn);
			return lista;
		}
		catch (Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}

	@Override
	public ArrayList<Producto> ObtenerMasVendidos(String opcion) {
		
		Connection cn = null;
		ArrayList<Producto> lista = new ArrayList<Producto>();
		String query = "SELECT Fecha, detallesfacturas.IdProducto, urlimagen, nombre, sum(cantidad) FROM facturas inner join detallesfacturas on facturas.IdFactura = detallesfacturas.IdFactura inner join productos on detallesfacturas.IdProducto = productos.IdProducto";
		
		if(opcion.equals("dia")) query += " where fecha = CURRENT_DATE()";
		if(opcion.equals("semana")) query += " where yearweek(fecha) = yearweek(CURRENT_DATE())";
		if(opcion.equals("mes")) query += " where month(fecha) = month(CURRENT_DATE())";
			
		query += " group by detallesfacturas.IdProducto order by sum(cantidad) desc";
		
		try 
		{
			cn = Conexion.Open();
			Statement st = cn.createStatement();
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next())
			{
				Producto producto = new Producto();
				producto.setId(rs.getInt(2));
				producto.setNombre(rs.getString(4));
				producto.setUrlImagen(rs.getString(3));
				producto.setStock(rs.getInt(5));
				lista.add(producto);
			}
			
			Conexion.Close(cn);
			return lista;
		}
		catch (Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}

}
