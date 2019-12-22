package negocioImpl;

import java.util.ArrayList;

import datos.TipoProductoDao;
import datosImpl.TipoProductoDaoImpl;
import entidad.TipoProducto;
import negocio.TipoProductoNeg;

public class TipoProductoNegImpl implements TipoProductoNeg{

	private TipoProductoDao tipoDao = new TipoProductoDaoImpl();
	
	@Override
	public boolean AgregarTipoProducto(TipoProducto tipoProducto) {
		return tipoDao.AgregarTipoProducto(tipoProducto);
	}

	@Override
	public boolean ModificarTipoProducto(TipoProducto tipoProducto) {
		return tipoDao.ModificarTipoProducto(tipoProducto);
	}

	@Override
	public boolean EliminarTipoProducto(int id) {
		return tipoDao.EliminarTipoProducto(id);
	}

	@Override
	public TipoProducto ObtenerTipoProducto(int id) {
		return tipoDao.ObtenerTipoProducto(id);
	}

	@Override
	public ArrayList<TipoProducto> ObtenerTodos() {
		return tipoDao.ObtenerTodos();
	}

}
