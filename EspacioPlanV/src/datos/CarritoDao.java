package datos;

import java.util.ArrayList;
import entidad.ProductoCarrito;
import entidad.Usuario;

public interface CarritoDao {
	
	public abstract boolean AgregarProducto(Usuario usuario, ProductoCarrito producto);

	public abstract boolean EliminarProducto(Usuario usuario, ProductoCarrito producto);
	
	public abstract boolean EliminarProducto(int idProducto);
	
	public abstract boolean ModificarProducto(Usuario usuario, ProductoCarrito producto);
	
	public abstract ArrayList<ProductoCarrito> ListarTodos(Usuario usuario);
	
	public abstract ProductoCarrito ObtenerProducto(Usuario usuario, ProductoCarrito productoNuevo);
}
