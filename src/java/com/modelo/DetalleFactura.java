/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.modelo;

/**
 *
 * @author rocke
 */
public class DetalleFactura
{
    private int codigo;
    private int codigoFactura;
    private int codigoProducto;
    private int cantidad;
    private double total;

    public DetalleFactura()
    {
    }

    public DetalleFactura(int codigo, int codigoFactura, int codigoProducto, int cantidad, double total)
    {
        this.codigo = codigo;
        this.codigoFactura = codigoFactura;
        this.codigoProducto = codigoProducto;
        this.cantidad = cantidad;
        this.total = total;
    }

    public int getCodigo()
    {
        return codigo;
    }

    public void setCodigo(int codigo)
    {
        this.codigo = codigo;
    }

    public int getCodigoFactura()
    {
        return codigoFactura;
    }

    public void setCodigoFactura(int codigoFactura)
    {
        this.codigoFactura = codigoFactura;
    }

    public int getCodigoProducto()
    {
        return codigoProducto;
    }

    public void setCodigoProducto(int codigoProducto)
    {
        this.codigoProducto = codigoProducto;
    }

    public int getCantidad()
    {
        return cantidad;
    }

    public void setCantidad(int cantidad)
    {
        this.cantidad = cantidad;
    }

    public double getTotal()
    {
        return total;
    }

    public void setTotal(double total)
    {
        this.total = total;
    }

    
}
