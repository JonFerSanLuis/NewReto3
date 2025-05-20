package com.bilbaoskp.model;

import java.util.Date;

public class Partida {
    private int id;
    private String nombre;
    private String tipoPartida; // "centro" o "ordinaria"
    private Date fecha;

    // Constructores
    public Partida() {
    }

    public Partida(int id, String nombre, String tipoPartida, Date fecha) {
        this.id = id;
        this.nombre = nombre;
        this.tipoPartida = tipoPartida;
        this.fecha = fecha;
    }

    // Getters y Setters
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

    public String getTipoPartida() {
        return tipoPartida;
    }

    public void setTipoPartida(String tipoPartida) {
        this.tipoPartida = tipoPartida;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    @Override
    public String toString() {
        return "Partida{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", tipoPartida='" + tipoPartida + '\'' +
                ", fecha=" + fecha +
                '}';
    }
}