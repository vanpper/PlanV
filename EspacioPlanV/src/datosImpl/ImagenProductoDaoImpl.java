package datosImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import datos.ImagenProductoDao;
import entidad.ImagenProducto;

public class ImagenProductoDaoImpl implements ImagenProductoDao {

	@Override
	public boolean AgregarImagen(int idProducto, ImagenProducto imagen) {
		
		Connection cn = null;
		
		String query = "INSERT INTO imagenesxproducto VALUES(?,?,?)";
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, idProducto);
			pst.setString(2, imagen.getUrlImagen());
			pst.setBoolean(3, imagen.getEstado());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}
	}

	@Override
	public boolean EliminarImagen(int idProducto, ImagenProducto imagen) {
		
		Connection cn = null;
		
		String query = "DELETE FROM imagenesxproducto WHERE IdProducto = ? AND UrlImagen = ?";
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1, idProducto);
			pst.setString(2, imagen.getUrlImagen());
			pst.executeUpdate();
			Conexion.Close(cn);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return false;
		}
	}

	@Override
	public ArrayList<ImagenProducto> ObtenerTodasImagenes(int idProducto) {
		
		Connection cn = null;
		ArrayList<ImagenProducto> lista = new ArrayList<ImagenProducto>();
		String query = "SELECT * FROM imagenesxproducto WHERE IdProducto = " + idProducto;
		
		try {
			cn = Conexion.Open();
			Statement st = cn.createStatement();
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next())
			{
				ImagenProducto imagen = new ImagenProducto();
				imagen.setUrlImagen(rs.getString(2));
				imagen.setEstado(rs.getBoolean(3));
				
				lista.add(imagen);
			}
			
			Conexion.Close(cn);
			return lista;
		}
		catch (Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}
	
	
	@Override
	public ImagenProducto ObtenerUltimaImagen() {
		
		Connection cn = null;
		ArrayList<ImagenProducto> lista = new ArrayList<ImagenProducto>();
		String query = "SELECT * FROM imagenesxproducto";
		
		try {
			cn = Conexion.Open();
			Statement st = cn.createStatement();
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next())
			{
				ImagenProducto imagen = new ImagenProducto();
				imagen.setUrlImagen(rs.getString(2));
				imagen.setEstado(rs.getBoolean(3));
				lista.add(imagen);
			}
			
			Conexion.Close(cn);
			if(lista.size()>0) {
				return lista.get(lista.size()-1);
			}else {
				return null ;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}
}
