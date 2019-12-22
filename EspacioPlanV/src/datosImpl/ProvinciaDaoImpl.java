package datosImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import datos.ProvinciaDao;
import entidad.Ciudad;
import entidad.Provincia;

public class ProvinciaDaoImpl implements ProvinciaDao{

	@Override
	public Provincia Obtener(int id) {
		
		Connection cn = null;
		Provincia provincia = new Provincia();
		String query = "SELECT * FROM provincia WHERE id = " + id;
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			
			if(rs.next()){
				provincia.setId(rs.getInt(1));
				provincia.setNombre(rs.getString(2));
			}
			
			Conexion.Close(cn);
			return provincia;
		}
		catch (Exception e) {
			e.printStackTrace();
			Conexion.Close(cn);
			return null;
		}
	}

	@Override
	public ArrayList<Provincia> ObtenerTodas() {
		
		Connection cn = null;
		ArrayList<Provincia> lista = new ArrayList<Provincia>();
		String query = "SELECT * FROM provincia";
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			
			while(rs.next()){
				Provincia provincia = new Provincia();
				provincia.setId(rs.getInt(1));
				provincia.setNombre(rs.getString(2));
				lista.add(provincia);
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
	public ArrayList<Ciudad> ObtenerCiudades(int provincia) {
		Connection cn = null;
		ArrayList<Ciudad> lista = new ArrayList<Ciudad>();
		String query = "SELECT * FROM localidad WHERE provincia_id = "+provincia+" AND NOT nombre = '' ORDER BY nombre ASC";
		
		try {
			cn = Conexion.Open();
			PreparedStatement pst = cn.prepareStatement(query);
			ResultSet rs = pst.executeQuery(query);
			
			while(rs.next()){
				Ciudad ciudad = new Ciudad(rs.getInt("id"),rs.getString("nombre"));
				lista.add(ciudad);
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
