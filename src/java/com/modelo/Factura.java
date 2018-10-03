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
public class Factura
{
    private int codigo;
    private int numero;
    private int vendedor;
    private String nombreVendedor;
    private int cliente;
    private String nombreCliente;
    double total;
    double totalIVA;
    String fecha;

    public Factura()
    {
    }

    public Factura(int codigo, int numero, int vendedor, String nombreVendedor, int cliente, String nombreCliente, double total, double totalIVA, String fecha)
    {
        this.codigo = codigo;
        this.numero = numero;
        this.vendedor = vendedor;
        this.nombreVendedor = nombreVendedor;
        this.cliente = cliente;
        this.nombreCliente = nombreCliente;
        this.total = total;
        this.totalIVA = totalIVA;
        this.fecha = fecha;
    }

    public int getCodigo()
    {
        return codigo;
    }

    public void setCodigo(int codigo)
    {
        this.codigo = codigo;
    }

    public int getNumero()
    {
        return numero;
    }

    public void setNumero(int numero)
    {
        this.numero = numero;
    }

    public int getVendedor()
    {
        return vendedor;
    }

    public void setVendedor(int vendedor)
    {
        this.vendedor = vendedor;
    }

    public String getNombreVendedor()
    {
        return nombreVendedor;
    }

    public void setNombreVendedor(String nombreVendedor)
    {
        this.nombreVendedor = nombreVendedor;
    }

    public int getCliente()
    {
        return cliente;
    }

    public void setCliente(int cliente)
    {
        this.cliente = cliente;
    }

    public String getNombreCliente()
    {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente)
    {
        this.nombreCliente = nombreCliente;
    }

    public double getTotal()
    {
        return total;
    }

    public void setTotal(double total)
    {
        this.total = total;
    }

    public double getTotalIVA()
    {
        return totalIVA;
    }

    public void setTotalIVA(double totalIVA)
    {
        this.totalIVA = totalIVA;
    }

    public String getFecha()
    {
        return fecha;
    }

    public void setFecha(String fecha)
    {
        this.fecha = fecha;
    }

    
}
