package negocio;

import java.util.ArrayList;
import java.util.List;

import entidad.ImagenProducto;

public interface ImagenProductoNeg {

	public abstract boolean AgregarImagen(ImagenProducto imagen);
	
	public abstract boolean EliminarImagen(ImagenProducto imagen);
	
	public abstract ArrayList<ImagenProducto> ObtenerTodasImagenes(int idProducto);
}
