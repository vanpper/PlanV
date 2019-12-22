package entidad;

public class Usuario {

	private int id;
	private String mail;
	private String dni;
	private TipoUsuario tipo;
	private String nombre;
	private String apellido;
	private Fecha fechaNacimiento;
	private int ciudad;
	private String direccion;
	private String telefono;
	private Provincia provincia;
	private String clave;
	private boolean estado;
	
	public Usuario() {
		
	}
	
	public Usuario(int id, String mail, String dni, TipoUsuario tipo, String nombre, String apellido, Fecha fechaNacimiento, int ciudad, String direccion, String telefono, String clave, Provincia provincia, boolean estado) {
		this.id = id;
		this.mail = mail;
		this.dni = dni;
		this.tipo = tipo;
		this.nombre = nombre;
		this.apellido = apellido;
		this.fechaNacimiento = fechaNacimiento;
		this.ciudad = ciudad;
		this.direccion = direccion;
		this.telefono = telefono;
		this.clave = clave;
		this.provincia = provincia;
		this.estado = estado;
	}
	
	public int getId() {
		return this.id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getMail() {
		return mail;
	}
	
	public void setMail(String mail) {
		this.mail = mail;
	}
	
	public String getDni() {
		return dni;
	}
	
	public void setDni(String dni) {
		this.dni = dni;
	}
	
	public TipoUsuario getTipo() {
		return tipo;
	}
	
	public void setTipo(TipoUsuario tipo) {
		this.tipo = tipo;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public String getApellido() {
		return apellido;
	}
	
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	
	public Fecha getFechaNacimiento() {
		return fechaNacimiento;
	}
	
	public void setFechaNacimiento(Fecha fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	
	public Provincia getProvincia() {
		return provincia;
	}

	public void setProvincia(Provincia provincia) {
		this.provincia = provincia;
	}

	public int getCiudad() {
		return ciudad;
	}
	
	public void setCiudad(int ciudad) {
		this.ciudad = ciudad;
	}
	
	public String getDireccion() {
		return direccion;
	}
	
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	
	public String getTelefono() {
		return telefono;
	}
	
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	
	public String getClave() {
		return clave;
	}
	
	public void setClave(String clave) {
		this.clave = clave;
	}
	
	public boolean getEstado() {
		return estado;
	}
	
	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	@Override
	public String toString() {
		return "Usuario [id=" + id + ", mail=" + mail + ", dni=" + dni + ", tipo=" + tipo + ", nombre=" + nombre
				+ ", apellido=" + apellido + ", fechaNacimiento=" + fechaNacimiento + ", ciudad=" + ciudad
				+ ", direccion=" + direccion + ", telefono=" + telefono + ", provincia=" + provincia + ", clave="
				+ clave + ", estado=" + estado + "]";
	}
}
