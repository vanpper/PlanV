package negocioImpl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.regex.Pattern;
import datos.CarritoDao;
import datos.DetalleFacturaDao;
import datos.FacturaDao;
import datos.ImagenProductoDao;
import datos.ProductoDao;
import datos.UsuarioDao;
import datosImpl.CarritoDaoImpl;
import datosImpl.DetalleFacturaDaoImpl;
import datosImpl.FacturaDaoImpl;
import datosImpl.ImagenProductoDaoImpl;
import datosImpl.ProductoDaoImpl;
import datosImpl.UsuarioDaoImpl;
import entidad.DetalleFactura;
import entidad.Factura;
import entidad.Fecha;
import entidad.ImagenProducto;
import entidad.Producto;
import entidad.Usuario;
import negocio.ProductoNeg;

public class ProductoNegImpl implements ProductoNeg{

	private ProductoDao productoDao = new ProductoDaoImpl();
	private ImagenProductoDao imagenDao = new ImagenProductoDaoImpl();
	private CarritoDao carritoDao = new CarritoDaoImpl();
	
	@Override
	public boolean AgregarProducto(Producto producto) {
		boolean res = productoDao.AgregarProducto(producto);
		
		if(res) {
			producto.setId(productoDao.ObtenerUltimoProducto().getId());
			ArrayList<ImagenProducto> imagenes = producto.getListaImagenes();
			for(int i=0; i<imagenes.size(); i++) {
				if(!imagenDao.AgregarImagen(producto.getId(),imagenes.get(i))) return false;
			}
		}
		
		return res;
	}

	@Override
	public boolean ModificarProducto(Producto producto,int imgs) {
		boolean res = productoDao.ModificarProducto(producto);
		
		if(res) {
			ArrayList<ImagenProducto> imagenes = producto.getListaImagenes();
			for(int i=0; i<imgs; i++) {
				if(!imagenes.get(i).getEstado())
					if(!imagenDao.EliminarImagen(producto.getId(),imagenes.get(i))) {
						return false;
					}
			}
			for(int i=imgs; i<imagenes.size(); i++) {
				if(!imagenDao.AgregarImagen(producto.getId(),imagenes.get(i))) return false;
			}
		}
		
		return res;
	}

	@Override
	public boolean EliminarProducto(int idProducto) {
		Producto producto = new Producto();
		producto.setId(idProducto);
		
		if(carritoDao.EliminarProducto(idProducto))
		{
			if(productoDao.EliminarProducto(producto))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		else 
		{
			return false;
		}
	}

	@Override
	public Producto ObtenerProducto(int id) {
		
		Producto producto = productoDao.ObtenerProducto(id);
		if(producto == null) return null;
		
		ArrayList<ImagenProducto> lista = imagenDao.ObtenerTodasImagenes(id);
		if(lista == null) return null;
		
		producto.setListaImagenes(lista);
		return producto;
	}
	
	public boolean ComprarProducto(int idUsuario, int idProducto, int cantidad) {
		
		UsuarioDao usuarioDao = new UsuarioDaoImpl();
		FacturaDao facturaDao = new FacturaDaoImpl();
		DetalleFacturaDao detalleDao = new DetalleFacturaDaoImpl();
		
		//OBTENER EL USUARIO Y PRODUCTO COMPLETOS
		Usuario usuario = usuarioDao.ObtenerUsuarioXId(idUsuario);
		Producto producto = productoDao.ObtenerProducto(idProducto);
		
		//VERIFICAR SI SE PUDIERON OBTENER
		if(usuario == null || producto == null) return false;
		
		//OBTENER MONTO DE LA FACTURA
		int monto = (producto.getPrecio() - (producto.getPrecio() * producto.getDescuento() / 100)) * cantidad;
		
		//GENERAR LA FACTURA
		Factura factura = new Factura();
		factura.setUsuario(usuario);
		factura.setMonto(monto);
		factura.setFecha(new Fecha(1, 1, 2001)); //OBTENER FECHA DEL SISTEMA
		factura.setEstado(true);
		
		//AGREGAR LA FACTURA A LA BASE DE DATOS Y VERIFICAR LA OPERACION
		if(!facturaDao.AgregarFactura(factura)) return false;
		
		//OBTENER LA MISMA FACTURA (PERO ESTA CONTIENE EL ID)
		factura = facturaDao.ObtenerUltimaFactura();
		
		//COMPROBAR SI SE PUDO OBTENER
		if(factura == null) return false;
		
		//GENERAR EL DETALLE DE FACTURA
		DetalleFactura detalle = new DetalleFactura();
		detalle.setProducto(producto);
		detalle.setPrecioUnitario(producto.getPrecio() - (producto.getPrecio() * producto.getDescuento() / 100));
		detalle.setCantidad(cantidad);
		detalle.setEstado(true);
		
		//AGREGAR A LA BASE DE DATOS EL DETALLE Y VERIFICAR LA OPERACION
		if(!detalleDao.AgregarDetalleFactura(factura, detalle)) return false;
		
		//DESCONTAR STOCK DEL PRODUCTO
		producto.setStock(producto.getStock() - cantidad);
		productoDao.ModificarProducto(producto);
		
		return true;
	}

	@Override
	public ArrayList<Producto> ListarTodosPorCategoria(int categoria, int sort, int min, int max, String substring) {
		ArrayList<Producto> lista = productoDao.ListarTodos(categoria,min,max,substring);
		Producto.sort = sort;
		Collections.sort(lista);
		return lista;
	}
	
	@Override
	public int ObtenerUltimaImagenPerfil() {
		Producto p = productoDao.ObtenerUltimoProducto();
		if(p != null) {
			return Integer.parseInt(p.getUrlImagen().split(Pattern.quote("."))[0])+1;
		}else {
			return 0;
		}
	}
	
	@Override
	public int ObtenerUltimaImagen() {
		ImagenProducto i = imagenDao.ObtenerUltimaImagen();
		if(i != null) {
			return Integer.parseInt(i.getUrlImagen().split(Pattern.quote("."))[0])+1;
		}else {
			return 0;
		}
	}

	@Override
	public ArrayList<Producto> ListarTodos() {
		return productoDao.ListarTodos();
	}

	@Override
	public ArrayList<Producto> ObtenerMasVendidos(String opcion) {
		return productoDao.ObtenerMasVendidos(opcion);
	}
}
