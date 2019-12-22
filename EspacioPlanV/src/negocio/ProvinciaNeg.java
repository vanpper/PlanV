package negocio;

import java.util.ArrayList;

import entidad.Ciudad;
import entidad.Provincia;

public interface ProvinciaNeg {

	public abstract Provincia Obtener(int id);
	
	public abstract ArrayList<Provincia> ObtenerTodas();
	
	public ArrayList<Ciudad> ObtenerCiudades(int provincia);
}
