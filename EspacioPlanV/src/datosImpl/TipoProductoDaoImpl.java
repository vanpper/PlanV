package datosImpl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import datos.TipoProductoDao;
import entidad.TipoProducto;

public class TipoProductoDaoImpl implements TipoProductoDao{
	
	@Override
	public boolean AgregarTipoProducto(TipoProducto tipoProducto) {
		
		Connection cn = null;
		
		String query = "INSERT INTO tipoproductos(Nombre, Descripcion, Estado) VALUES(?, ?, ?)";
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setString(1, tipoProducto.getNombre());
			pst.setString(2, tipoProducto.getDescripcion());
			pst.setBoolean(3, tipoProducto.getEstado());
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
	public boolean ModificarTipoProducto(TipoProducto tipoProducto) {
		
		Connection cn = null;
		
		String query = "UPDATE tipoproductos SET Nombre = ?, Descripcion = ?, Estado = ? WHERE IdTipoProducto = ?";
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setString(1, tipoProducto.getNombre());
			pst.setString(2, tipoProducto.getDescripcion());
			pst.setBoolean(3, tipoProducto.getEstado());
			pst.setInt(4,tipoProducto.getId());
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
	public boolean EliminarTipoProducto(int id) {
		
		Connection cn = null;
		
		String query = "UPDATE tipoproductos SET Estado = 0 WHERE IdTipoProducto = ?";
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			pst.setInt(1,id);
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
	public TipoProducto ObtenerTipoProducto(int id) {
		Connection cn = null;
		TipoProducto tipoProducto = new TipoProducto();
		String query = "SELECT * FROM tipoproductos WHERE IdTipoProducto = " + id;
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			if(rs.next()){
				tipoProducto.setId(rs.getInt(1));
				tipoProducto.setNombre(rs.getString(2));
				tipoProducto.setDescripcion(rs.getString(3));
				tipoProducto.setEstado(rs.getBoolean(4));
			}else {
				Conexion.Close(cn);
				return null;
			}
			Conexion.Close(cn);
			return tipoProducto;
		}
		catch (Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}

	@Override
	public ArrayList<TipoProducto> ObtenerTodos() {
		
		Connection cn = null;
		ArrayList<TipoProducto> lista = new ArrayList<TipoProducto>();
		
		String query = "SELECT * FROM tipoproductos";
		
		try {
			cn = Conexion.Open();
			Statement st = cn.createStatement();
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next()) {
				TipoProducto tipoProducto = new TipoProducto();
				tipoProducto.setId(rs.getInt(1));
				tipoProducto.setNombre(rs.getString(2));
				tipoProducto.setDescripcion(rs.getString(3));
				tipoProducto.setEstado(rs.getBoolean(4));
				lista.add(tipoProducto);
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

}
