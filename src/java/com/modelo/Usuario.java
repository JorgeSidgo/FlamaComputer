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
public class Usuario
{
    private int codigoUsuario;
    private String nombreUsuario;
    private String pass;
    private int codigoRol;

    public Usuario()
    {
    }

    public Usuario(int codigoUsuario, String nombreUsuario, String pass, int codigoRol)
    {
        this.codigoUsuario = codigoUsuario;
        this.nombreUsuario = nombreUsuario;
        this.pass = pass;
        this.codigoRol = codigoRol;
    }

    public int getCodigoUsuario()
    {
        return codigoUsuario;
    }

    public void setCodigoUsuario(int codigoUsuario)
    {
        this.codigoUsuario = codigoUsuario;
    }

    public String getNombreUsuario()
    {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario)
    {
        this.nombreUsuario = nombreUsuario;
    }

    public String getPass()
    {
        return pass;
    }

    public void setPass(String pass)
    {
        this.pass = pass;
    }

    public int getCodigoRol()
    {
        return codigoRol;
    }

    public void setCodigoRol(int codigoRol)
    {
        this.codigoRol = codigoRol;
    }
    
    
}
