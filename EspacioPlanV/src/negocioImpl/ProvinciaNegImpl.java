package negocioImpl;

import java.util.ArrayList;

import datos.ProvinciaDao;
import datosImpl.ProvinciaDaoImpl;
import entidad.Ciudad;
import entidad.Provincia;
import negocio.ProvinciaNeg;

public class ProvinciaNegImpl implements ProvinciaNeg{

	private ProvinciaDao provinciaDao = new ProvinciaDaoImpl();
	
	@Override
	public Provincia Obtener(int id) {
		return provinciaDao.Obtener(id);
	}

	@Override
	public ArrayList<Provincia> ObtenerTodas() {
		return provinciaDao.ObtenerTodas();
	}
	
	public ArrayList<Ciudad> ObtenerCiudades(int provincia) {
		return provinciaDao.ObtenerCiudades(provincia);
	}

}
