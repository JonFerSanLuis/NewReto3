package com.bilbaoskp.model;

import java.sql.Date;

public class Cupon {
	private int idCupon;
	private int idSuscriptor;
	private String tipo;
	private Date fechaCaducidad;
	private String estado;
	
	public Cupon() {
		super();
	}

	public Cupon(int idCupon, int idSuscriptor, String tipo, Date fechaCaducidad, String estado) {
		super();
		this.idCupon = idCupon;
		this.idSuscriptor = idSuscriptor;
		this.tipo = tipo;
		this.fechaCaducidad = fechaCaducidad;
		this.estado = estado;
	}

	public int getIdCupon() {
		return idCupon;
	}

	public void setIdCupon(int idCupon) {
		this.idCupon = idCupon;
	}

	public int getIdSuscriptor() {
		return idSuscriptor;
	}

	public void setIdSuscriptor(int idSuscriptor) {
		this.idSuscriptor = idSuscriptor;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Date getFechaCaducidad() {
		return fechaCaducidad;
	}

	public void setFechaCaducidad(Date fechaCaducidad) {
		this.fechaCaducidad = fechaCaducidad;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
	
	
}
