package datos;

import java.util.ArrayList;

import entidad.Producto;

public interface ProductoDao {
	
	public abstract boolean AgregarProducto(Producto producto);
	
	public abstract boolean ModificarProducto(Producto producto);
	
	public abstract boolean EliminarProducto(Producto producto);
	
	public abstract ArrayList<Producto> ListarTodos(int categoria, int min, int max, String substring);

	public abstract Producto ObtenerProducto(int id);

	Producto ObtenerUltimoProducto();

	ArrayList<Producto> ListarTodos();

	ArrayList<Producto> ObtenerMasVendidos(String opcion);

}
