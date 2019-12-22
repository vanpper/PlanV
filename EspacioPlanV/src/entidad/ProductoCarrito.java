package entidad;

public class ProductoCarrito {

	private Producto producto;
	private int cantidad;
	private boolean estado;
	
	public ProductoCarrito() {	}

	public ProductoCarrito(Producto producto, int cantidad, boolean estado) {
		super();
		this.producto = producto;
		this.cantidad = cantidad;
		this.estado = estado;
	}

	public Producto getProducto() {
		return producto;
	}

	public void setProducto(Producto producto) {
		this.producto = producto;
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
	
}
	
