package entidad;

import java.util.ArrayList;
import java.util.List;

public class Factura {

	private int id;
	private Usuario usuario;
	private int monto;
	private Fecha fecha;
	private boolean estado;
	private List<DetalleFactura> detalles = new ArrayList<DetalleFactura>();
	
	public Factura() {
		
	}

	public Factura(int id, Usuario usuario, int monto, Fecha fecha, boolean estado, List<DetalleFactura> detalles) {
		super();
		this.id = id;
		this.usuario = usuario;
		this.monto = monto;
		this.fecha = fecha;
		this.estado = estado;
		this.detalles = detalles;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public int getMonto() {
		return monto;
	}

	public void setMonto(int monto) {
		this.monto = monto;
	}

	public Fecha getFecha() {
		return fecha;
	}

	public void setFecha(Fecha fecha) {
		this.fecha = fecha;
	}

	public boolean getEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	public List<DetalleFactura> getDetalles() {
		return detalles;
	}
	
	public void setDetalle(ArrayList<DetalleFactura> lista)
	{
		this.detalles = lista;
	}

	public void addDetalle(DetalleFactura detalle) {
		this.detalles.add(detalle);
	}
	
	
}
