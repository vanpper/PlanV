package datos;

import java.util.ArrayList;
import entidad.Ciudad;
import entidad.Provincia;

public interface ProvinciaDao {

	public abstract Provincia Obtener(int id);
	
	public abstract ArrayList<Provincia> ObtenerTodas();
	
	public abstract ArrayList<Ciudad> ObtenerCiudades(int provincia);
}
