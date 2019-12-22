package negocio;

import java.util.ArrayList;

import entidad.ProductoCarrito;
import entidad.Usuario;

public interface CarritoNeg {
	
	public abstract boolean AgregarProducto(Usuario usuario, int idProducto, int cantidad);

	public abstract boolean EliminarProducto(Usuario usuario, int idProducto);
	
	public abstract boolean EliminarProducto(int idProducto);
	
	public abstract boolean ModificarProducto(Usuario usuario, ProductoCarrito producto);
	
	public abstract ArrayList<ProductoCarrito> ListarTodos(Usuario usuario);
	
	public abstract boolean ComprarCarrito(Usuario usuario);

	boolean ModificarProducto(Usuario usuario, int id, int cant);
}
