package com.dao;

import com.conexion.Conexion;
import com.modelo.Rol;
import java.sql.*;

/**
 * Nombre de la Clase: DaoUsuario 
 * Version: 1.0 
 * Fecha: 17/09/2018
 * @authors Jorge Sidgo-Pimentel 
 *          Benjamín Ramirez 
 *          Abdiel Martinez 
 *          Francisco Montoya
 */
public class DaoRol extends Conexion
{
    
    public String returnRol(int id) throws Exception
    {
        String rol = "";
        Rol r = new Rol();
        
        try
        {
            this.conectar();
            String sql = "select descRol from rol where codigoRol = ?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet res = pre.executeQuery();
            res.next();
            rol = res.getString("descRol");
        } catch (Exception e)
        {
        }
        finally
        {
            this.desconectar();
        }
        
        return rol;
    }
    
}
