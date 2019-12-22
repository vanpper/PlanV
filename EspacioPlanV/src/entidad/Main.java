package entidad;

import java.io.Console;
import java.util.List;
import java.util.regex.Pattern;

import negocio.ProductoNeg;
import negocio.ProvinciaNeg;
import negocio.UsuarioNeg;
import negocioImpl.ProductoNegImpl;
import negocioImpl.ProvinciaNegImpl;
import negocioImpl.UsuarioNegImpl;

public class Main {

	public static void main(String[] args) {
		String separador = Pattern.quote(".");
		System.out.println(new String("cuadernos.jpg").split(separador).length);
	}

}
