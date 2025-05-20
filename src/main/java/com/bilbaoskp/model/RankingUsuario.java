package com.bilbaoskp.model;

public class RankingUsuario {
    private int posicion;
    private int id;
    private String nombre;
    private int puntuacion;
    private int nivel;
    private int partidas;
    
    public RankingUsuario() {
    }

	public RankingUsuario(int posicion, int id, String nombre, int puntuacion, int nivel, int partidas) {
		super();
		this.posicion = posicion;
		this.id = id;
		this.nombre = nombre;
		this.puntuacion = puntuacion;
		this.nivel = nivel;
		this.partidas = partidas;
	}

	public int getPosicion() {
		return posicion;
	}

	public void setPosicion(int posicion) {
		this.posicion = posicion;
	}

	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getPuntuacion() {
        return puntuacion;
    }

    public void setPuntuacion(int puntuacion) {
        this.puntuacion = puntuacion;
    }

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        this.nivel = nivel;
    }

    public int getPartidas() {
        return partidas;
    }

    public void setPartidas(int partidas) {
        this.partidas = partidas;
    }
}