package datos;

import java.util.ArrayList;

import entidad.DetalleFactura;
import entidad.Factura;

public interface DetalleFacturaDao {

	public abstract boolean AgregarDetalleFactura(Factura factura, DetalleFactura detalle);
	
	public abstract boolean ModificarDetalleFactura(Factura factura, DetalleFactura detalle);
	
	public abstract boolean EliminarDetalleFactura(Factura factura, int idProducto);
	
	public abstract ArrayList<DetalleFactura> ObtenerDetalleCompleto(Factura factura);
	
	public abstract ArrayList<DetalleFactura> ObtenerTodos();
}
