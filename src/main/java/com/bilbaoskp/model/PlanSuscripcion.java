package com.bilbaoskp.model;

public class PlanSuscripcion {
    private String tipoSuscripcion;
    private String descripcion;
    private int precio;

    // Constructores
    public PlanSuscripcion() {
    }

    public PlanSuscripcion(String tipoSuscripcion, String descripcion, int precio) {
        this.tipoSuscripcion = tipoSuscripcion;
        this.descripcion = descripcion;
        this.precio = precio;
    }

    // Getters y Setters
    public String getTipoSuscripcion() {
        return tipoSuscripcion;
    }

    public void setTipoSuscripcion(String tipoSuscripcion) {
        this.tipoSuscripcion = tipoSuscripcion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    @Override
    public String toString() {
        return "PlanSuscripcion{" +
                "tipoSuscripcion='" + tipoSuscripcion + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", precio=" + precio +
                '}';
    }
}