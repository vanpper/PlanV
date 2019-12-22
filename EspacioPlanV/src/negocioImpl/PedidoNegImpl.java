package negocioImpl;

import java.util.ArrayList;
import datos.MensajeDao;
import datos.PedidoDao;
import datosImpl.MensajeDaoImpl;
import datosImpl.PedidoDaoImpl;
import entidad.Fecha;
import entidad.MensajeChat;
import entidad.Pedido;
import entidad.TipoProducto;
import entidad.Usuario;
import negocio.PedidoNeg;

public class PedidoNegImpl implements PedidoNeg{

	private PedidoDao pedidoDao = new PedidoDaoImpl();
	private MensajeDao mensajeDao = new MensajeDaoImpl();
	
	@Override
	public boolean ModificarPedido(Pedido pedido) {
		return pedidoDao.ModificarPedido(pedido);
	}

	@Override
	public boolean EliminarPedido(Pedido pedido) {
		return pedidoDao.EliminarPedido(pedido);
	}

	@Override
	public ArrayList<Pedido> ListarPedidos(Usuario usuario, int categoria, int estado){
		return pedidoDao.ListarPedidos(usuario, categoria, estado);
	}

	@Override
	public Pedido ObtenerPedido(int id) {
		return pedidoDao.ObtenerPedido(id);
	}

	@Override
	public boolean EliminarPedido(int idPedido) {
		
		Pedido pedido = new Pedido();
		pedido.setId(idPedido);
		
		return pedidoDao.EliminarPedido(pedido);
	}

	@Override
	public boolean AgregarPedido(int idUsuario, int idCategoria, String tamaño, String orientacion, String anillado, String descripcion) {
		
		Pedido pedido = new Pedido();
		Usuario usuario = new Usuario();
		usuario.setId(idUsuario);
		pedido.setUsuario(usuario);
		TipoProducto tipoProducto = new TipoProductoNegImpl().ObtenerTipoProducto(idCategoria);
		pedido.setTipoProducto(tipoProducto);
		pedido.setPrecio(0);
		pedido.setFecha(new Fecha(10, 10, 10)); //<-------------- INGRESAR FECHA DEL SISTEMA
		pedido.setEstado(1);
		
		if(!pedidoDao.AgregarPedido(pedido)) return false;
		
		pedido = pedidoDao.ObtenerUltimoPedido(usuario);
		if(pedido == null) return false;
		
		MensajeChat mensaje = new MensajeChat();
		mensaje.setPedido(pedido);
		
		if(anillado.equals("1")) anillado = "Doble metal";
		if(anillado.equals("2")) anillado = "Metal";
		if(anillado.equals("3")) anillado = "Plastico";
		
		mensaje.setMensaje("Se solicita un producto de tipo: " + tipoProducto.getNombre() + ", tamaño: " + tamaño + ", orientacion: " + orientacion + ", anillado: " + anillado + ". Descripcion del cliente: " + descripcion);
		mensaje.setFecha(new Fecha(10, 10, 10)); //<--------------------- INGRESAR FECHA DEL SISTEMA
		mensaje.setEstado(1);
		
		if(!mensajeDao.AgregarMensaje(mensaje, mensaje.getPedido().getId())) return false;
		
		return true;
	}

	@Override
	public Pedido ObtenerUltimoPedido(Usuario usuario) {
		// TODO Auto-generated method stub
		return null;
	}

}
