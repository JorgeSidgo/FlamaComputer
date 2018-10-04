
package com.dao;

import com.conexion.Conexion;
import com.modelo.Vendedor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Nombre de la clase: DaoVendedor
 * Fecha: 28-09-18
 * Version: 1.0
 * Copyright: ITCA FEPADE
 * @author Javier Montoya
 */

public class DaoVendedor extends Conexion{
        
    public String mostrarVendedor() throws Exception
    {
        ResultSet res;
        String vendedor = "";
        
        try
        {
            this.conectar();
            String sql = "call mostrarVendedor";
            PreparedStatement pre = this.getCon().prepareCall(sql);
            res = pre.executeQuery();
            
            while(res.next())
            {
                String eliminar = "";
                String editar = "";
                
                eliminar = "<button id=\\\"" + res.getInt("codigoVendedor") + "\\\" class=\\\"ui btnEliminar icon negative small button\\\"><i class=\\\"trash icon\\\"></i></button>";
                editar = "<button id=\\\"" + res.getInt("codigoVendedor") + "\\\" class=\\\"ui btnEditar icon primary small button\\\"><i class=\\\"edit icon\\\"></i></button>";
                
                    vendedor += "{\n" + "\"Codigo Vendedor\": \"" + res.getInt("codigoVendedor") + "\", " + "\"Nombre\": \"" + res.getString("nombre") + "\", " + "\"Apellido\": \"" + res.getString("apellidos") + "\", "
                        + "\"Dui\":\"" + res.getString("dui") + "\"," + "\"Dirección\": \"" + res.getString("direccion")  + "\", " + "\"Telefono Oficina\":\"" + res.getString("telefonoOficina") + "\","
                        + "\"Telefono Movil\":\"" + res.getString("telefonoMovil") + "\"," + "\"Codigo Usuario\":\"" + res.getInt("codigoUsuario") + "\"," + "\"Acciones\":\""+editar + " " + eliminar + "\"" + "},";
            }
            
            vendedor = vendedor.substring(0, vendedor.length()-1);
        } 
        catch (Exception e) 
        {
            System.out.print(e.getMessage());
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        
        return "{\"data\":["+ vendedor + "]}";
    }
    
    public int codigoVendedorId(int id) throws Exception {
        int idVend = 0;
        
        try
        {
            this.conectar();
            String sql = "select codigoVendedor from vendedor where codigoUsuario = ?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, id);
            
            ResultSet res = pre.executeQuery();
            res.next();
            
            idVend = res.getInt("codigoVendedor");
        } catch (Exception e)
        {
        }
        finally{
            this.desconectar();
        }
        
        return idVend;
    }
    
    public boolean insertarVendedor(Vendedor v) throws Exception
    {
        boolean estado = false;
        
        try
        {
            this.conectar();
            String sql = "call insertarVendedor(?,?,?,?,?,?)";
            PreparedStatement pre = this.getCon().prepareCall(sql);
            //pre.setInt(1, v.getCodigoVendedor());
            pre.setString(1, v.getNombre());
            pre.setString(2, v.getApellido());
            pre.setString(3, v.getDui());
            pre.setString(4, v.getDirecciones());
            pre.setString(5, v.getTelOficina());
            pre.setString(6, v.getTelMov());
            estado = pre.execute();
        }
        catch (Exception e) 
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        
        return estado;
    }
    
    public void modificarVendedor(Vendedor v) throws Exception
    {
        try
        {
            this.conectar();
            String sql = "call modificarVendedor(?,?,?,?,?,?,?)";
            PreparedStatement pre = this.getCon().prepareCall(sql);
            pre.setString(1, v.getDui());
            pre.setString(2, v.getNombre());
            pre.setString(3, v.getApellido());
            pre.setString(4, v.getDirecciones());
            pre.setString(5, v.getTelOficina());
            pre.setString(6, v.getTelMov());
            pre.setInt(7, v.getCodigoVendedor());
            pre.executeUpdate();
        }
        catch(Exception e)
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
    }
    
    public void eliminarVendedor(int codigo, int proceso) throws Exception
    {
        // 1=fisico, 2=logico
        switch(proceso)
        {
            case 1:
                try 
                {
                    this.conectar();
                    String sql = "call eliminarFisicoVendedor(?)";
                    PreparedStatement pre = this.getCon().prepareCall(sql);
                    pre.setInt(1, codigo);
                    pre.executeQuery();
                }
                catch (Exception e) 
                {
                    throw e;
                }
                finally
                {
                    this.desconectar();
                }
                break;
                
            case 2:
                 try 
                {
                    this.conectar();
                    String sql = "call eliminarlogicoVendedor(?)";
                    PreparedStatement pre = this.getCon().prepareCall(sql);
                    pre.setInt(1, codigo);
                    pre.executeQuery();
                }
                catch (Exception e) 
                {
                    throw e;
                }
                finally
                {
                    this.desconectar();
                }
                break;
                
            default:
                break;
        }
    }
}
