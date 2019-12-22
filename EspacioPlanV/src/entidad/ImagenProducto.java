package entidad;

public class ImagenProducto {

	private String urlImagen;
	private boolean estado;
	
	public ImagenProducto() {
		
	}
	
	public ImagenProducto(String urlImagen, boolean estado) {
		this.urlImagen = urlImagen;
		this.estado = estado;
	}
	
	public String getUrlImagen() {
		return urlImagen;
	}
	
	public void setUrlImagen(String urlImagen) {
		this.urlImagen = urlImagen;
	}
	
	public boolean getEstado() {
		return estado;
	}
	
	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	
	@Override
	public String toString() {
		return "ImagenProducto [urlImagen=" + urlImagen + ", estado=" + estado + "]";
	}
}
