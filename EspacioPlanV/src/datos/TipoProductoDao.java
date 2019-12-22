package datos;

import java.util.ArrayList;

import entidad.TipoProducto;

public interface TipoProductoDao {

	public abstract boolean AgregarTipoProducto(TipoProducto tipoProducto);
	
	public abstract boolean ModificarTipoProducto(TipoProducto tipoProducto);
	
	public abstract boolean EliminarTipoProducto(int id);
	
	public abstract TipoProducto ObtenerTipoProducto(int id);
	
	public abstract ArrayList<TipoProducto> ObtenerTodos();
}
