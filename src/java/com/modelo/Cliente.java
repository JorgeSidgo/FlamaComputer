package com.modelo;

/**
 *
 * @author rocke
 */
public class Cliente
{
    private int codigo;
    private String nombre;
    private String apellidos;
    private String direccion;

    public Cliente()
    {
    }

    public Cliente(int codigo, String nombre, String apellidos, String direccion)
    {
        this.codigo = codigo;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.direccion = direccion;
    }

    public int getCodigo()
    {
        return codigo;
    }

    public void setCodigo(int codigo)
    {
        this.codigo = codigo;
    }

    public String getNombre()
    {
        return nombre;
    }

    public void setNombre(String nombre)
    {
        this.nombre = nombre;
    }

    public String getApellidos()
    {
        return apellidos;
    }

    public void setApellidos(String apellidos)
    {
        this.apellidos = apellidos;
    }

    public String getDireccion()
    {
        return direccion;
    }

    public void setDireccion(String direccion)
    {
        this.direccion = direccion;
    }
    
    
}
