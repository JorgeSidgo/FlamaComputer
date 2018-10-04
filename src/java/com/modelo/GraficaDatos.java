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
public class GraficaDatos
{
    private String nombreMes;
    private int cantidad;

    public GraficaDatos()
    {
    }

    public GraficaDatos(String nombreMes, int cantidad)
    {
        this.nombreMes = nombreMes;
        this.cantidad = cantidad;
    }

    public String getNombreMes()
    {
        return nombreMes;
    }

    public void setNombreMes(String nombreMes)
    {
        this.nombreMes = nombreMes;
    }

    public int getCantidad()
    {
        return cantidad;
    }

    public void setCantidad(int cantidad)
    {
        this.cantidad = cantidad;
    }

    
    
    
}
