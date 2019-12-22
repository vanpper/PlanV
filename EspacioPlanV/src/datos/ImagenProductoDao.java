package datos;

import java.util.ArrayList;
import entidad.ImagenProducto;

public interface ImagenProductoDao {

	public abstract boolean AgregarImagen(int idProducto, ImagenProducto imagen);
	
	public abstract boolean EliminarImagen(int idProducto, ImagenProducto imagen);
	
	public abstract ArrayList<ImagenProducto> ObtenerTodasImagenes(int idProducto);

	ImagenProducto ObtenerUltimaImagen();

}
