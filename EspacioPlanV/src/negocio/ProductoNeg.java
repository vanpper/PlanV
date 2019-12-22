package negocio;

import java.util.ArrayList;

import entidad.Producto;

public interface ProductoNeg {

	public abstract boolean AgregarProducto(Producto producto);
	
	public abstract boolean ModificarProducto(Producto producto, int imgs);
	
	public abstract boolean EliminarProducto(int idProducto);
	
	public abstract Producto ObtenerProducto(int id);
	
	public abstract boolean ComprarProducto(int idUsuario, int idProducto, int cantidad);
	
	public abstract ArrayList<Producto> ListarTodosPorCategoria(int categoria, int sort, int min, int max, String substring);

	int ObtenerUltimaImagenPerfil();

	int ObtenerUltimaImagen();

	ArrayList<Producto> ListarTodos();

	ArrayList<Producto> ObtenerMasVendidos(String opcion);
}
