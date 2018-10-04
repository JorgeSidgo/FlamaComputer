package com.modelo;

/**
 * Nombre de la Clase: Vendedor
 * Version: 1.0
 * Fecha: 28-09-18
 * Copyright: ITCA-FEPADE
 * @author Javier Montoya
 */

public class Vendedor {
    private int codigoVendedor;
    private String dui;
    private String nombre;
    private String apellido;
    private String direcciones;
    private String telOficina;
    private String telMov;
    private int codigoUsuario;
    
    public Vendedor() {
    }

    public Vendedor(int codigoVendedor, String dui, String nombre, String apellido, String direcciones, String telOficina, String telMov, int codigoUsuario) {
        this.codigoVendedor = codigoVendedor;
        this.dui = dui;
        this.nombre = nombre;
        this.apellido = apellido;
        this.direcciones = direcciones;
        this.telOficina = telOficina;
        this.telMov = telMov;
        this.codigoUsuario = codigoUsuario;
    }

    public int getCodigoVendedor() {
        return codigoVendedor;
    }

    public void setCodigoVendedor(int codigoVendedor) {
        this.codigoVendedor = codigoVendedor;
    }

    public String getDui() {
        return dui;
    }

    public void setDui(String dui) {
        this.dui = dui;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getDirecciones() {
        return direcciones;
    }

    public void setDirecciones(String direcciones) {
        this.direcciones = direcciones;
    }

    public String getTelOficina() {
        return telOficina;
    }

    public void setTelOficina(String telOficina) {
        this.telOficina = telOficina;
    }

    public String getTelMov() {
        return telMov;
    }

    public void setTelMov(String telMov) {
        this.telMov = telMov;
    }

    public int getCodigoUsuario() {
        return codigoUsuario;
    }

    public void setCodigoUsuario(int codigoUsuario) {
        this.codigoUsuario = codigoUsuario;
    }
}
    