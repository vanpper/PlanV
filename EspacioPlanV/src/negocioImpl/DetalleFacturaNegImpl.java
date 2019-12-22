package negocioImpl;

import java.util.ArrayList;

import datos.DetalleFacturaDao;
import datosImpl.DetalleFacturaDaoImpl;
import entidad.DetalleFactura;
import entidad.Factura;
import negocio.DetalleFacturaNeg;

public class DetalleFacturaNegImpl implements DetalleFacturaNeg {

	private DetalleFacturaDao detalleDao = new DetalleFacturaDaoImpl();
	
	@Override
	public boolean AgregarDetalleFactura(Factura factura, DetalleFactura detalle) {
		return detalleDao.AgregarDetalleFactura(factura, detalle);
	}

	@Override
	public boolean ModificarDetalleFactura(Factura factura, DetalleFactura detalle) {
		return detalleDao.ModificarDetalleFactura(factura, detalle);
	}

	@Override
	public boolean EliminarDetalleFactura(Factura factura, int idProducto) {
		return detalleDao.EliminarDetalleFactura(factura, idProducto);
	}

	@Override
	public ArrayList<DetalleFactura> ObtenerDetalleCompleto(Factura factura) {
		return detalleDao.ObtenerDetalleCompleto(factura);
	}

	@Override
	public ArrayList<DetalleFactura> ObtenerTodas() {
		return detalleDao.ObtenerTodos();
	}

}
