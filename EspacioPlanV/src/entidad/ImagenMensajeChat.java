package entidad;

public class ImagenMensajeChat {

	private String urlImagen;
	private boolean estado;
	
	public ImagenMensajeChat() {}

	public ImagenMensajeChat(String urlImagen, boolean estado) {
		super();
		this.urlImagen = urlImagen;
		this.estado = estado;
	}

	public String getUrlImagen() {
		return urlImagen;
	}

	public void setUrlImagen(String urlImagen) {
		this.urlImagen = urlImagen;
	}

	public boolean isEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	
}
