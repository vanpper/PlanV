package entidad;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class Fecha {

	private int dia;
	private int mes;
	private int año;
	
	public Fecha(){
		
	}
	
	public Fecha(String fecha, int x){
		this.dia = Integer.parseInt(fecha.split("-")[2]);
		this.mes = Integer.parseInt(fecha.split("-")[1]);
		this.año = Integer.parseInt(fecha.split("-")[0]);
	}
	
	public Fecha(String fecha){
		fecha = fecha.split(" ")[0];
		this.dia = Integer.parseInt(fecha.split("-")[2]);
		this.mes = Integer.parseInt(fecha.split("-")[1]);
		this.año = Integer.parseInt(fecha.split("-")[0]);
	}
	
	public Fecha(int dia, int mes, int año){
		this.dia = dia;
		this.mes = mes;
		this.año = año;
	}
	
	public Fecha(Date date) {
		//SETEAR FECHA  CON UN OBJETO DE TIPO DATE
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		this.dia = calendar.get(Calendar.DAY_OF_MONTH);
		this.mes = calendar.get(Calendar.MONTH) + 1;
		this.mes = calendar.get(Calendar.YEAR);
	}

	public int getDia() {
		return dia;
	}

	public void setDia(int dia) {
		this.dia = dia;
	}

	public int getMes() {
		return mes;
	}

	public void setMes(int mes) {
		this.mes = mes;
	}

	public int getAño() {
		return año;
	}

	public void setAño(int año) {
		this.año = año;
	}
	
	public String toMySQLFormat() {	//DEVUELVE LA FECHA COMPLETA EN EL FORMATO MYSQL
		return año + "-" + mes + "-" + dia;
	}
	
	public String toDateFormat() {
		String d;
		String m;
		
		if(this.dia < 10) {
			d = "0" + this.dia;
		}else {
			d = String.valueOf(this.dia);
		}
		
		if(this.mes < 10) {
			m = "0" + this.mes;
		}else {
			m = String.valueOf(this.mes);
		}
		
		return this.año + "-" + m + "-" + d;
	}

	@Override
	public String toString() {
		String d;
		String m;
		
		if(this.dia < 10) {
			d = "0" + this.dia;
		}else {
			d = String.valueOf(this.dia);
		}
		
		if(this.mes < 10) {
			m = "0" + this.mes;
		}else {
			m = String.valueOf(this.mes);
		}
		
		return d + "-" + m + "-" + this.año;
	}
}
