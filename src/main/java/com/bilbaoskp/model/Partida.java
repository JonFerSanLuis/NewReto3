package com.bilbaoskp.model;

import java.util.Date;

public class Partida {
    private String nombre;
    private String tipoPartida;
    private Date fecha;
    private String idioma; 

    public Partida() {}

    public Partida(String nombre, String tipoPartida, Date fecha, String idioma) {
        this.nombre = nombre;
        this.tipoPartida = tipoPartida;
        this.fecha = fecha;
        this.idioma = idioma;
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

    public String getIdioma() {
        return idioma;
    }

    public void setIdioma(String idioma) {
        this.idioma = idioma;
    }

    @Override
    public String toString() {
        return "Partida{" +
                "nombre='" + nombre + '\'' +
                ", tipoPartida='" + tipoPartida + '\'' +
                ", fecha=" + fecha +
                ", idioma='" + idioma + '\'' +
                '}';
    }
}
