package entidad;

import java.util.ArrayList;

public class Pedido {

	private int id;
	private Usuario usuario;
	private TipoProducto tipoProducto;
	private int precio;
	private Fecha fecha;
	private int estado;
	private ArrayList<MensajeChat> mensajes;
	
	public Pedido() {
		
	}

	public Pedido(int id, Usuario usuario, TipoProducto tipoProducto, int precio, Fecha fecha, int estado,
			ArrayList<MensajeChat> mensajes) {
		super();
		this.id = id;
		this.usuario = usuario;
		this.tipoProducto = tipoProducto;
		this.precio = precio;
		this.fecha = fecha;
		this.estado = estado;
		this.mensajes = mensajes;
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

	public TipoProducto getTipoProducto() {
		return tipoProducto;
	}

	public void setTipoProducto(TipoProducto tipoProducto) {
		this.tipoProducto = tipoProducto;
	}

	public int getPrecio() {
		return precio;
	}

	public void setPrecio(int precio) {
		this.precio = precio;
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
	
	public int CantidadMensajes() {
		return mensajes.size();
	}

	public MensajeChat getMensaje(int index) {
		return mensajes.get(index);
	}

	public void addMensaje(MensajeChat mensaje) {
		this.mensajes.add(mensaje);
	}
	
}
