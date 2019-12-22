package datos;

import java.util.ArrayList;

import entidad.Factura;
import entidad.Usuario;

public interface FacturaDao {

	public abstract boolean AgregarFactura(Factura factura);
	
	public abstract boolean ModificarFactura(Factura factura);
	
	public abstract boolean EliminarFactura(Factura factura);
	
	public abstract Factura ObtenerFactura(int idFactura);
	
	public abstract Factura ObtenerUltimaFactura();
	
	public abstract ArrayList<Factura> ListarTodas(Usuario usuario);

	int ObtenerCantidadVentas(String opcion);

	ArrayList<Factura> ObtenerFacturacion(String opcion);
	
}
