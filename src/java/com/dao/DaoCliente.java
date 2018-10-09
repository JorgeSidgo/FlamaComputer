/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author jsidg
 */
public class DaoCliente extends Conexion
{
    public String mostrarClientes() throws Exception
    {
        String usuarios = "";
        try
        {
            this.conectar();
            String sql = "select * from cliente";
            PreparedStatement pre = this.getCon().prepareStatement(sql);

            ResultSet res = pre.executeQuery();

            while (res.next())
            {

                usuarios += "{\n"
                        + "\"codigoCliente\": \"" + res.getInt("codigoCliente") + "\", "
                        + "\"Nombre\": \"" + res.getString("nombre") + "\", "
                        + "\"Apellido\": \"" + res.getString("apellidos") + "\", "
                        + "\"Direccion\": \""+ res.getString("direccion") + "\""
                        + "},";
            }

            usuarios = usuarios.substring(0, usuarios.length() - 1);
        } catch (Exception e)
        {
            System.out.print(e.getMessage());
            throw e;
        } finally
        {
            this.desconectar();
        }

        return "{\"data\": [" + usuarios + "]}";
    }
}
