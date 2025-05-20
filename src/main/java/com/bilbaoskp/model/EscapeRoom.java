package com.bilbaoskp.model;

public class EscapeRoom {
    private int id;
    private int idPartida;
    private int tiempoSeg;
    private int pistasUsadas;
    private int puntosTotales;
    private String tipoSuscriptor; // "centro" o "ordinario"

    // Constructores
    public EscapeRoom() {
    }

    public EscapeRoom(int id, int idPartida, int tiempoSeg, int pistasUsadas, int puntosTotales, String tipoSuscriptor) {
        this.id = id;
        this.idPartida = idPartida;
        this.tiempoSeg = tiempoSeg;
        this.pistasUsadas = pistasUsadas;
        this.puntosTotales = puntosTotales;
        this.tipoSuscriptor = tipoSuscriptor;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdPartida() {
        return idPartida;
    }

    public void setIdPartida(int idPartida) {
        this.idPartida = idPartida;
    }

    public int getTiempoSeg() {
        return tiempoSeg;
    }

    public void setTiempoSeg(int tiempoSeg) {
        this.tiempoSeg = tiempoSeg;
    }

    public int getPistasUsadas() {
        return pistasUsadas;
    }

    public void setPistasUsadas(int pistasUsadas) {
        this.pistasUsadas = pistasUsadas;
    }

    public int getPuntosTotales() {
        return puntosTotales;
    }

    public void setPuntosTotales(int puntosTotales) {
        this.puntosTotales = puntosTotales;
    }

    public String getTipoSuscriptor() {
        return tipoSuscriptor;
    }

    public void setTipoSuscriptor(String tipoSuscriptor) {
        this.tipoSuscriptor = tipoSuscriptor;
    }

    @Override
    public String toString() {
        return "EscapeRoom{" +
                "id=" + id +
                ", idPartida=" + idPartida +
                ", tiempoSeg=" + tiempoSeg +
                ", pistasUsadas=" + pistasUsadas +
                ", puntosTotales=" + puntosTotales +
                ", tipoSuscriptor='" + tipoSuscriptor + '\'' +
                '}';
    }
}