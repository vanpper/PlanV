package entidad;

public class TipoUsuario {
	
	private int id;
	private String descripcion;
	private boolean estado;
	
	public TipoUsuario() {
		
	}
	
	public TipoUsuario(int id, String descripcion, boolean estado) {
		this.id = id;
		this.descripcion = descripcion;
		this.estado = estado;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public boolean getEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	@Override
	public String toString() {
		return "TipoDeUsuario [id=" + id + ", descripcion=" + descripcion + ", estado=" + estado + "]";
	}
}
