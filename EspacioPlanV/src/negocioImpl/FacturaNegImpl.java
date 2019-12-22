package negocioImpl;

import java.util.ArrayList;
import datos.DetalleFacturaDao;
import datos.FacturaDao;
import datosImpl.DetalleFacturaDaoImpl;
import datosImpl.FacturaDaoImpl;
import entidad.Factura;
import entidad.Usuario;
import negocio.FacturaNeg;

public class FacturaNegImpl implements FacturaNeg {

	private FacturaDao facturaDao = new FacturaDaoImpl();
	private DetalleFacturaDao detalleDao = new DetalleFacturaDaoImpl();
	
	@Override
	public boolean AgregarFactura(Factura factura) {
		return facturaDao.AgregarFactura(factura);
	}

	@Override
	public boolean ModificarFactura(Factura factura) {
		return facturaDao.ModificarFactura(factura);
	}

	@Override
	public boolean EliminarFactura(Factura factura) {
		return facturaDao.EliminarFactura(factura);
	}

	@Override
	public Factura ObtenerFactura(int idFactura) {
		return facturaDao.ObtenerFactura(idFactura);
	}

	@Override
	public ArrayList<Factura> ListarTodas(Usuario usuario) {
		
		ArrayList<Factura> listaFacturas = facturaDao.ListarTodas(usuario);
		
		for(Factura factura : listaFacturas)
		{
			factura.setDetalle(detalleDao.ObtenerDetalleCompleto(factura));
		}
		
		return listaFacturas;
	}

	@Override
	public Factura ObtenerUltimaFactura() {
		return facturaDao.ObtenerUltimaFactura();
	}

	@Override
	public int ObtenerCantidadVentas(String opcion) {
		return facturaDao.ObtenerCantidadVentas(opcion);
	}

	@Override
	public ArrayList<Factura> ObtenerFacturacion(String opcion) {
		return facturaDao.ObtenerFacturacion(opcion);
	}

}
