package negocioImpl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.regex.Pattern;

import javax.servlet.http.Part;

import negocio.ImagenesNeg;

public class ImagenesNegImpl implements ImagenesNeg{

	@Override
	public String guardarImagen(Part archivo, String context, String carpeta, int name) {
		/*
		String foto = Paths.get(archivo.getSubmittedFileName()).getFileName().toString(); 
		foto = name +"."+ foto.split(Pattern.quote("."))[1];
	    try {
			archivo.write(context + File.separator + carpeta + File.separator + foto);
			return foto;
		} catch (IOException e) {
			e.printStackTrace();
		} 
		*/
		String nombre = name + "." + Paths.get(archivo.getSubmittedFileName()).getFileName().toString().split(Pattern.quote("."))[1];

		File uploads = new File("C:/path/to/uploads/"+carpeta);
		File file = new File(uploads, nombre);
		try {
			if (!Files.exists(uploads.toPath()))
			    Files.createDirectories(uploads.toPath());
			if(Files.exists(file.toPath()))
				Files.delete(file.toPath());
			InputStream input = archivo.getInputStream();
			Files.copy(input, file.toPath());
			return nombre;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

}
