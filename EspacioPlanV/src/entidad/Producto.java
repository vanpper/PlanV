package entidad;

import java.util.ArrayList;

public class Producto implements Comparable<Object>{

	public static int sort = 1;
	private int id;
	private TipoProducto tipo;
	private String nombre;
	private String descripcion;
	private int precio;
	private int descuento;
	private int stock;
	private String urlImagen;
	private ArrayList<ImagenProducto> listaImagenes = new ArrayList<ImagenProducto>();
	private boolean estado;
	
	public Producto() {
		listaImagenes = new ArrayList<ImagenProducto>();
	}
	
	public Producto(int id, TipoProducto tipo, String nombre, String descripcion, int precio, int descuento,
			int stock, String urlImagen, boolean estado) {
		this.id = id;
		this.tipo = tipo;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.precio = precio;
		this.descuento = descuento;
		this.stock = stock;
		this.urlImagen = urlImagen;
		this.estado = estado;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public TipoProducto getTipo() {
		return this.tipo;
	}
	
	public void setTipo(TipoProducto tipo) {
		this.tipo = tipo;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public String getDescripcion() {
		return descripcion;
	}
	
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public int getPrecio() {
		return precio;
	}
	
	public void setPrecio(int precio) {
		this.precio = precio;
	}
	
	public int getDescuento() {
		return descuento;
	}
	
	public void setDescuento(int descuento) {
		this.descuento = descuento;
	}
	
	public int getStock() {
		return stock;
	}
	
	public void setStock(int stock) {
		this.stock = stock;
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
	
	public ArrayList<ImagenProducto> getListaImagenes() {
		return listaImagenes;
	}

	public void setListaImagenes(ArrayList<ImagenProducto> listaImagenes) {
		this.listaImagenes = listaImagenes;
	}
	
	public void addImagen(ImagenProducto imagen) {
		this.listaImagenes.add(imagen);
	}

	@Override
	public String toString() {
		return "Producto [id=" + id + ", tipo=" + tipo + ", nombre=" + nombre + ", descripcion=" + descripcion
				+ ", precio=" + precio + ", descuento=" + descuento + ", stock=" + stock + ", urlImagen=" + urlImagen
				+ ", estado=" + estado + "]";
	}

	@Override
	public int compareTo(Object o) {
		Producto p = (Producto)o;
		switch(sort) {
		case 1:return this.nombre.compareTo(p.getNombre());
		case 2:return this.nombre.compareTo(p.getNombre())*(-1);
		case 3:{if(this.precio-(this.precio*this.descuento/100)>p.getPrecio()-(p.getPrecio()*p.getDescuento()/100)) return 1; else return -1;}
		case 4:{if(this.precio-(this.precio*this.descuento/100)>p.getPrecio()-(p.getPrecio()*p.getDescuento()/100)) return -1; else return 1;}
		}
		return 0;
	}
}
