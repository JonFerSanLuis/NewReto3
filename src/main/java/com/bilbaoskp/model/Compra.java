package com.bilbaoskp.model;

import java.util.Date;

public class Compra {
    private int codCompra;
    private double pago;
    private Date fecha;
    private int idSuscriptor;

    // Constructores
    public Compra() {
    }

    public Compra(int codCompra, double pago, Date fecha, int idSuscriptor) {
        this.codCompra = codCompra;
        this.pago = pago;
        this.fecha = fecha;
        this.idSuscriptor = idSuscriptor;
    }

    // Getters y Setters
    public int getCodCompra() {
        return codCompra;
    }

    public void setCodCompra(int codCompra) {
        this.codCompra = codCompra;
    }

    public double getPago() {
        return pago;
    }

    public void setPago(double pago) {
        this.pago = pago;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public int getIdSuscriptor() {
        return idSuscriptor;
    }

    public void setIdSuscriptor(int idSuscriptor) {
        this.idSuscriptor = idSuscriptor;
    }

    @Override
    public String toString() {
        return "Compra{" +
                "codCompra=" + codCompra +
                ", pago=" + pago +
                ", fecha=" + fecha +
                ", idSuscriptor=" + idSuscriptor +
                '}';
    }
}