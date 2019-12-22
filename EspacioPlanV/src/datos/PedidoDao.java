package datos;

import java.util.ArrayList;
import entidad.Pedido;
import entidad.Usuario;

public interface PedidoDao {

	public abstract boolean AgregarPedido(Pedido pedido);
	
	public abstract boolean ModificarPedido(Pedido pedido);
	
	public abstract boolean EliminarPedido(Pedido pedido);
	
	public abstract ArrayList<Pedido> ListarPedidos(Usuario usuario, int categoria, int estado);
	
	public abstract Pedido ObtenerPedido(int id);
	
	public abstract Pedido ObtenerUltimoPedido(Usuario usuario);
}
