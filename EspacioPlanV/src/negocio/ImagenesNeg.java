package negocio;

import javax.servlet.http.Part;

public interface ImagenesNeg {
	public abstract String guardarImagen(Part archivo, String context,String carpeta, int name);
}
