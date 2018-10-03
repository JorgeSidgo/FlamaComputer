package com.modelo;

/**
 * Nombre de la Clase: Producto
 * Version: 1.0
 * Fecha de Creación: 24 de Septiembre de 2018
 * CopyRight: ITCA-FEPADE
 * @author Benjamín Ramírez
 */
public class Producto {
    
    private int codigoProducto;
    private String nombreProducto;
    private double precioVenta;
    private int stockMinimo;
    private int stockActual;
    private String codigoBarra;

    public Producto() {
    }

    public Producto(int codigoProducto, String nombreProducto, double precioVenta, int stockMinimo, int stockActual, String codigoBarra) {
        this.codigoProducto = codigoProducto;
        this.nombreProducto = nombreProducto;
        this.precioVenta = precioVenta;
        this.stockMinimo = stockMinimo;
        this.stockActual = stockActual;
        this.codigoBarra = codigoBarra;
    }

    public int getCodigoProducto() {
        return codigoProducto;
    }

    public void setCodigoProducto(int codigoProducto) {
        this.codigoProducto = codigoProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public double getPrecioVenta() {
        return precioVenta;
    }

    public void setPrecioVenta(double precioVenta) {
        this.precioVenta = precioVenta;
    }

    public int getStockMinimo() {
        return stockMinimo;
    }

    public void setStockMinimo(int stockMinimo) {
        this.stockMinimo = stockMinimo;
    }

    public int getStockActual() {
        return stockActual;
    }

    public void setStockActual(int stockActual) {
        this.stockActual = stockActual;
    }

    public String getCodigoBarra() {
        return codigoBarra;
    }

    public void setCodigoBarra(String codigoBarra) {
        this.codigoBarra = codigoBarra;
    }
    
}
