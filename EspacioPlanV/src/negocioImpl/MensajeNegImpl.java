package negocioImpl;

import java.util.ArrayList;
import datos.MensajeDao;
import datosImpl.MensajeDaoImpl;
import entidad.MensajeChat;
import negocio.MensajeNeg;

public class MensajeNegImpl implements MensajeNeg{

	private MensajeDao mensajeDao = new MensajeDaoImpl();
	
	@Override
	public boolean AgregarMensaje(MensajeChat mensaje, int idPedido) {
		return mensajeDao.AgregarMensaje(mensaje, idPedido);
	}

	@Override
	public boolean ModificarMensaje(MensajeChat mensaje, int idPedido) {
		return mensajeDao.ModificarMensaje(mensaje, idPedido);
	}

	@Override
	public boolean EliminarMensaje(MensajeChat mensaje) {
		return mensajeDao.EliminarMensaje(mensaje);
	}

	@Override
	public ArrayList<MensajeChat> ListarMensajes(int idPedido) {
		return mensajeDao.ListarMensajes(idPedido);
	}

	@Override
	public boolean AgregarImagen(MensajeChat Mensaje) {
		return mensajeDao.AgregarImagen(Mensaje);
	}

	@Override
	public void ListarImagenes(MensajeChat Mensaje) {
		mensajeDao.ListarImagenes(Mensaje);
	}

}
