package com.conexion;

import java.sql.*;

/**
 * Nombre de la Clase: Conexion
 * Version: 1.0
 * Fecha: 17/09/2018
 * @authors Jorge Sidgo-Pimentel
 *          Benjamín Ramirez
 *          Abdiel Martinez
 *          Francisco Montoya
 */
public class Conexion
{
    private Connection con;
    private final String DB_URL = "jdbc:mysql://localhost:3306/facturacion?user=root&password=";

    public Connection getCon()
    {
        return con;
    }

    public void setCon(Connection con)
    {
        this.con = con;
    }
    
    public void conectar() throws Exception
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL);
        } catch (SQLException  | ClassNotFoundException e)
        {
            throw e;
        }
    }
    
    public void desconectar() throws Exception
    {
        try
        {
            if(this.con != null)
            {
                if(!this.con.isClosed())
                {
                    con.close();
                }
            }
        } 
        catch (SQLException e)
        {
            throw e;
        }
    }
}
