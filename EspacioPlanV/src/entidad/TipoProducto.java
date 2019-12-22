package entidad;

public class TipoProducto {

	private int id;
	private String nombre;
	private String descripcion;
	private boolean estado;
	
	public TipoProducto() {
		this.id = -1;
		this.nombre = "SIN NOMBRE";
		this.descripcion = "SIN DESCRIPCION";
		this.estado = true;
	}
	
	public TipoProducto(int id, String nombre, String descripcion, boolean estado) {
		this.id = id;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.estado = estado;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getNombre() {
		return this.nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public String getDescripcion() {
		return this.descripcion;
	}
	
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public boolean getEstado() {
		return this.estado;
	}
	
	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	@Override
	public String toString() {
		return "TipoProducto [id=" + id + ", nombre=" + nombre + ", descripcion=" + descripcion + ", estado=" + estado
				+ "]";
	}
}
