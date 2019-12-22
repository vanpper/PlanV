package entidad;

import java.util.ArrayList;

public class MensajeChat {

	private int id;
	private Pedido pedido;
	private String mensaje;
	private Usuario usuario;
	private Fecha fecha;
	private int estado;
	private ArrayList<ImagenMensajeChat> imagenes;
	
	public MensajeChat() {
		
	}

	public MensajeChat(int id, Pedido pedido, String mensaje, Fecha fecha, int estado,
			ArrayList<ImagenMensajeChat> imagenes) {
		super();
		this.id = id;
		this.pedido = pedido;
		this.mensaje = mensaje;
		this.fecha = fecha;
		this.estado = estado;
		this.imagenes = imagenes;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Pedido getPedido() {
		return pedido;
	}

	public void setPedido(Pedido pedido) {
		this.pedido = pedido;
	}

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public Fecha getFecha() {
		return fecha;
	}

	public void setFecha(Fecha fecha) {
		this.fecha = fecha;
	}

	public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	public int CantidadImagenes() {
		return imagenes.size();
	}

	public ImagenMensajeChat getImagen(int index) {
		return imagenes.get(index);
	}
	
	public void addImagen(ImagenMensajeChat imagen) {
		this.imagenes.add(imagen);
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
	
}
