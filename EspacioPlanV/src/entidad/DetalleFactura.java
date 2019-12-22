package entidad;

public class DetalleFactura {

	private int idfactura;
	private Producto producto;
	private int precioUnitario;
	private int cantidad;
	private boolean estado;
	
	public DetalleFactura() {
		
	}

	public DetalleFactura(Producto producto, int precioUnitario, int cantidad, boolean estado) {
		super();
		this.producto = producto;
		this.precioUnitario = precioUnitario;
		this.cantidad = cantidad;
		this.estado = estado;
	}

	public Producto getProducto() {
		return producto;
	}

	public void setProducto(Producto producto) {
		this.producto = producto;
	}

	public int getPrecioUnitario() {
		return precioUnitario;
	}

	public void setPrecioUnitario(int precioUnitario) {
		this.precioUnitario = precioUnitario;
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public boolean getEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	public int getIdfactura() {
		return idfactura;
	}

	public void setIdfactura(int idfactura) {
		this.idfactura = idfactura;
	}
	
	
}
