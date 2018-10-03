package com.modelo;

/**
 * Nombre de la Clase: Usuario
 * Version: 1.0
 * Fecha: 17/09/2018
 * @authors Jorge Sidgo-Pimentel
 *          Benjamín Ramirez
 *          Abdiel Martinez
 *          Francisco Montoya
 */
public class Rol
{
    private int codigoRol;
    private String abrRol;
    private String descRol;

    public Rol()
    {
    }

    public Rol(int codigoRol, String abrRol, String descRol)
    {
        this.codigoRol = codigoRol;
        this.abrRol = abrRol;
        this.descRol = descRol;
    }

    public int getCodigoRol()
    {
        return codigoRol;
    }

    public void setCodigoRol(int codigoRol)
    {
        this.codigoRol = codigoRol;
    }

    public String getAbrRol()
    {
        return abrRol;
    }

    public void setAbrRol(String abrRol)
    {
        this.abrRol = abrRol;
    }

    public String getDescRol()
    {
        return descRol;
    }

    public void setDescRol(String descRol)
    {
        this.descRol = descRol;
    }
    
    
}
