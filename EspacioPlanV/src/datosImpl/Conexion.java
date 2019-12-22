package datosImpl;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
	private final static String host = "jdbc:mysql://localhost:3306/";
	private final static String user = "root";
	private final static String pass = "ROOT";
	private final static String dbName = "planv?useSSL=false&allowPublicKeyRetrieval=true";

	protected Connection connection;
	
	public static Connection Open()
	{
		Connection conexion = null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection(host+dbName, user, pass);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return conexion;
	}
	
	public static boolean Close(Connection cn)
	{
		boolean ok=true;
		try {
			cn.close();
		}
		catch(Exception e)
		{
			ok= false;
			e.printStackTrace();
		}
		return ok;
	}
}
