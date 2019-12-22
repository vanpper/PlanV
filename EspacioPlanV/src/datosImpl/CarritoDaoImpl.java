package datosImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import datos.CarritoDao;
import datos.ProductoDao;
import entidad.Producto;
import entidad.ProductoCarrito;
import entidad.Usuario;

public class CarritoDaoImpl implements CarritoDao{
	
	@Override
	public boolean AgregarProducto(Usuario usuario, ProductoCarrito producto) {
		
		Connection cn = null;
		String query = "INSERT INTO carrito VALUES(?, ?, ?, ?)";
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			
			pst.setInt(1, usuario.getId());
			pst.setInt(2, producto.getProducto().getId());
			pst.setInt(3, producto.getCantidad());
			pst.setBoolean(4, producto.getEstado());
			
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
	public boolean EliminarProducto(Usuario usuario, ProductoCarrito producto) {
		
		Connection cn = null;
		String query = "DELETE FROM carrito WHERE IdUsuario = ? AND IdProducto = ?";
		
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1,usuario.getId());
			pst.setInt(2,producto.getProducto().getId());
			pst.executeUpdate();
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	@Override
	public boolean EliminarProducto(int idProducto) {
		
		Connection cn = null;
		String query = "DELETE FROM carrito WHERE IdProducto = " + idProducto;
		
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.executeUpdate();
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean ModificarProducto(Usuario usuario, ProductoCarrito producto) {
		
		Connection cn = null;
		String query = "UPDATE carrito SET Cantidad = ?, Estado = ? WHERE IdUsuario = ? AND IdProducto = ?";
		
		try
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			
			pst.setInt(1, producto.getCantidad());
			pst.setBoolean(2, producto.getEstado());
			pst.setInt(3, usuario.getId());
			pst.setInt(4, producto.getProducto().getId());
			
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
	public ArrayList<ProductoCarrito> ListarTodos(Usuario usuario) {
		
		String query = "SELECT * FROM carrito WHERE IdUsuario = " + usuario.getId();
		ArrayList<ProductoCarrito> lista = new ArrayList<ProductoCarrito>();
		Connection cn = null;
		ProductoDao productoDao = new ProductoDaoImpl();
		
		try 
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			
			while(rs.next())
			{
				ProductoCarrito productoCarrito = new ProductoCarrito();
				Producto producto = productoDao.ObtenerProducto(rs.getInt(2));
				productoCarrito.setProducto(producto);
				productoCarrito.setCantidad(rs.getInt(3));
				productoCarrito.setEstado(rs.getBoolean(4));
				lista.add(productoCarrito);
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
	public ProductoCarrito ObtenerProducto(Usuario usuario, ProductoCarrito productoNuevo) {
		String query = "SELECT * FROM carrito WHERE IdUsuario = " + usuario.getId() + " AND IdProducto = " + productoNuevo.getProducto().getId();
		Connection cn = null;
		ProductoDao productoDao = new ProductoDaoImpl();
		try 
		{
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			
			if(rs.next())
			{
				ProductoCarrito productoCarrito = new ProductoCarrito();
				Producto producto = productoDao.ObtenerProducto(rs.getInt(2));
				productoCarrito.setProducto(producto);
				productoCarrito.setCantidad(rs.getInt(3));
				productoCarrito.setEstado(rs.getBoolean(4));
				return productoCarrito;
			}
			Conexion.Close(cn);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			Conexion.Close(cn);
		}
		return null;
	}
}
