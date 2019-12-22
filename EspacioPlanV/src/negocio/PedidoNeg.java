package negocio;

import java.util.ArrayList;
import entidad.Pedido;
import entidad.Usuario;

public interface PedidoNeg {

	public abstract boolean AgregarPedido(int idUsuario, int idCategoria, String tamaño, String orientacion, String anillado, String descripcion);
	
	public abstract boolean ModificarPedido(Pedido pedido);
	
	public abstract boolean EliminarPedido(Pedido pedido);
	
	public abstract boolean EliminarPedido(int idPedido);
	
	public abstract ArrayList<Pedido> ListarPedidos(Usuario usuario, int categoria, int estado);
	
	public abstract Pedido ObtenerPedido(int id);
	
	public abstract Pedido ObtenerUltimoPedido(Usuario usuario);
}
