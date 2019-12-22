package negocioImpl;

import java.util.ArrayList;

import datos.CarritoDao;
import datos.DetalleFacturaDao;
import datos.FacturaDao;
import datos.ProductoDao;
import datosImpl.CarritoDaoImpl;
import datosImpl.DetalleFacturaDaoImpl;
import datosImpl.FacturaDaoImpl;
import datosImpl.ProductoDaoImpl;
import entidad.DetalleFactura;
import entidad.Factura;
import entidad.Fecha;
import entidad.Producto;
import entidad.ProductoCarrito;
import entidad.Usuario;
import negocio.CarritoNeg;

public class CarritoNegImpl implements CarritoNeg{

	private CarritoDao carritoDao = new CarritoDaoImpl();
	
	
	@Override
	public boolean AgregarProducto(Usuario usuario, int idProducto, int cantidad) {
		
		Producto producto = new Producto();
		producto.setId(idProducto);
		
		ProductoCarrito productoCarrito = new ProductoCarrito();
		productoCarrito.setProducto(producto);
		productoCarrito.setCantidad(cantidad);
		productoCarrito.setEstado(true);
		
		ProductoCarrito existe = carritoDao.ObtenerProducto(usuario, productoCarrito);
		if(existe == null) {
			return carritoDao.AgregarProducto(usuario, productoCarrito);
		}else {
			productoCarrito.setCantidad(cantidad + existe.getCantidad());
			if(cantidad + existe.getCantidad() <= producto.getStock()) {
				return carritoDao.ModificarProducto(usuario, productoCarrito);
			}else {
				return false;
			}
		}
	}

	@Override
	public boolean EliminarProducto(Usuario usuario, int idProducto) {
		
		Producto producto = new Producto();
		producto.setId(idProducto);
		
		ProductoCarrito productoCarrito = new ProductoCarrito();
		productoCarrito.setProducto(producto);
		
		return carritoDao.EliminarProducto(usuario, productoCarrito);
	}

	@Override
	public boolean ModificarProducto(Usuario usuario, ProductoCarrito producto) {
		return carritoDao.ModificarProducto(usuario, producto);
	}
	
	@Override
	public boolean ModificarProducto(Usuario usuario, int id, int cant) {
		return carritoDao.ModificarProducto(usuario, new ProductoCarrito(new ProductoDaoImpl().ObtenerProducto(id),cant,true));
	}

	@Override
	public ArrayList<ProductoCarrito> ListarTodos(Usuario usuario) {
		return carritoDao.ListarTodos(usuario);
	}

	@Override
	public boolean ComprarCarrito(Usuario usuario) {
		
		FacturaDao facturaDao = new FacturaDaoImpl();
		DetalleFacturaDao detalleDao = new DetalleFacturaDaoImpl();
		ProductoDao productoDao = new ProductoDaoImpl();
		int monto = 0;
		
		//OBTENER LOS PRODUCTOS QUE ESTABAN EN EL CARRITO
		ArrayList<ProductoCarrito> listaProductos = carritoDao.ListarTodos(usuario);
		
		//COMPROBAR SI SE PUDO OBTENER LOS PRODUCTOS O SI HABIA PRODUCTOS EN EL CARRITO
		if(listaProductos == null || listaProductos.size() == 0) return false; 
		
		//OBTENER EL MONTO TOTAL DEL CARRITO CON LOS RESPECTIVOS DESCUENTOS
		for(ProductoCarrito productoCarrito : listaProductos) {
			
			int descuento = productoCarrito.getProducto().getDescuento();
			int precio = productoCarrito.getProducto().getPrecio();
			int cantidad = productoCarrito.getCantidad();
			monto += (precio - (precio * descuento / 100)) * cantidad;
		}
		
		//GENERAR FACTURA
		Factura factura = new Factura();
		factura.setUsuario(usuario);
		factura.setMonto(monto);
		factura.setFecha(new Fecha(1, 1, 2001)); //OBTENER FECHA DEL SISTEMA
		factura.setEstado(true);
		
		//GUARDAR LA FACTURA EN LA BASE DE DATOS. COMPROBAR SI SE GUARDO CORRECTAMENTE
		if(!facturaDao.AgregarFactura(factura)) return false;
		
		//OBTENER LA MISMA FACTURA (PERO ESTA CONTIENE EL ID)
		factura = facturaDao.ObtenerUltimaFactura();
		
		if(factura == null) return false; //COMPROBAR SI SE PUDO OBTENER LA FACTURA
		
		//AGREGAR CADA PRODUCTO DEL CARRITO AL DETALLE DE FACTURA
		for(ProductoCarrito productoCarrito : listaProductos) {
			
			DetalleFactura detalle = new DetalleFactura(); //CREAR DETALLE FACTURA
			detalle.setProducto(productoCarrito.getProducto()); //AGREGAR AL DETALLE EL PRODUCTO
			detalle.setPrecioUnitario(productoCarrito.getProducto().getPrecio() - (productoCarrito.getProducto().getPrecio() * productoCarrito.getProducto().getDescuento() / 100)); //AGREGAR AL DETALLE EL PRECIO UNITARIO CON SU DESCUENTO
			detalle.setCantidad(productoCarrito.getCantidad()); //AGREGAR AL DETALLE LA CANTIDAD DEL PRODUCTO
			detalle.setEstado(true);
			
			//AGREGAR A LA BASE DE DATOS EL DETALLE GENERADO (1 SOLO PRODUCTO POR VUELTA). COMRPOBAR SI SE GUARDO CORRECTAMENTE
			if(!detalleDao.AgregarDetalleFactura(factura, detalle)) return false;
		}
		
		//DESCONTAR STOCK DE LOS PRODUCTOS COMPRADOS
		for(ProductoCarrito productoCarrito : listaProductos) {
			
			Producto producto = productoDao.ObtenerProducto(productoCarrito.getProducto().getId());
			producto.setStock(producto.getStock() - productoCarrito.getCantidad());
			productoDao.ModificarProducto(producto);
		}
		
		//BORRAR TODOS LOS PRODUCTOS DEL CARRITO DEL USUARIO
		for(ProductoCarrito productoCarrito : listaProductos) {
			
			if(!carritoDao.EliminarProducto(usuario, productoCarrito)) return false;
		}
		
		return true; //SI TODO SALIO BIEN DEVOLVER VERDADERO
	}

	@Override
	public boolean EliminarProducto(int idProducto) {
		return carritoDao.EliminarProducto(idProducto);
	}
}
