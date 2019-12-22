package datos;

import java.util.ArrayList;
import entidad.MensajeChat;

public interface MensajeDao {
	
	public abstract boolean AgregarMensaje(MensajeChat mensaje, int idPedido);
	
	public abstract boolean ModificarMensaje(MensajeChat mensaje, int idPedido);
	
	public abstract boolean EliminarMensaje(MensajeChat mensaje);
	
	public abstract ArrayList<MensajeChat> ListarMensajes(int idPedido);

	public abstract boolean AgregarImagen(MensajeChat Mensaje);
	
	public abstract void ListarImagenes(MensajeChat Mensaje);

}
