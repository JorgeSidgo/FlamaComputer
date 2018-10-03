package com.dao;

import com.conexion.Conexion;
import com.modelo.Producto;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Nombre de la Clase: DaoProducto
 * Version: 1.0
 * Fecha de Creación: 24 de Septiembre de 2018
 * CopyRight: ITCA-FEPADE
 * @author Benjamín Ramírez
 */
public class DaoProducto extends Conexion {
    public String mostrarProducto() throws Exception
    {
        String productos="";
        ResultSet res;
        try 
        {
            this.conectar();
            String sql = "call mostrarProducto();";
            PreparedStatement pre = this.getCon().prepareCall(sql); 
            res = pre.executeQuery();
            while(res.next())
            {
                String eliminar = "";
                String editar = "";
                
                editar = "<button id=\\\"" + res.getInt("codigoProducto") + "\\\"  class=\\\"ui btnEditar icon primary small button\\\"><i class=\\\"edit icon\\\"></i></button>";
                eliminar = "<button id=\\\"" + res.getInt("codigoProducto") + "\\\" @click=\\\"modalEliminar\\\" class=\\\"ui btnEliminar icon negative small button\\\"><i class=\\\"trash icon\\\"></i></button>";
                productos += "{\n"
                        + "\"idProducto\": \"" + res.getInt("codigoProducto") + "\", "
                        + "\"Producto\": \"" + res.getString("nombreProducto").replaceAll("\"","\\\\\"") + "\", "
                        + "\"Precio\": \"" + res.getDouble("precioVenta") + "\", "
                        + "\"StockMinimo\": \"" + res.getInt("stockMinimo") + "\", "
                        + "\"StockActual\": \"" + res.getInt("stockActual") + "\", "
                        + "\"Acciones\": \""+ editar + " " + eliminar + "\""
                        + "},";
            }
            productos = productos.substring(0, productos.length() - 1);
        } 
        catch (Exception e) 
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        return "{\"data\": [" + productos + "]}";
    }
    
    public Boolean insertarProducto(Producto prod) throws Exception
    {
        boolean respuesta = false;
        try 
        {
            this.conectar();
            String sql = "call insertarProducto(?,?,?,?,?);";
            PreparedStatement pre = this.getCon().prepareCall(sql);
            pre.setString(1, prod.getNombreProducto());
            pre.setDouble(2, prod.getPrecioVenta());
            pre.setInt(3, prod.getStockMinimo());
            pre.setInt(4, prod.getStockActual());
            pre.setString(5, prod.getCodigoBarra());
            int res = pre.executeUpdate();
            if(res > 0)
            {
                respuesta = true;
            }
        } 
        catch (Exception e) 
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        return respuesta;
    }
    
    public List<Producto> mostrarProductos() throws Exception
    {
        ResultSet res;
        List<Producto> list = new ArrayList();
        try 
        {
            this.conectar();
            String sql = "call mostrarProducto();";
            PreparedStatement pre = this.getCon().prepareCall(sql);
            Producto prod; 
            res = pre.executeQuery();
            while(res.next())
            {
                prod = new Producto(res.getInt("codigoProducto"), res.getString("nombreProducto"), res.getDouble("precioVenta"), res.getInt("stockMinimo"), res.getInt("stockActual"), res.getString("codigoBarra"));
                list.add(prod);
            }
        } 
        catch (Exception e) 
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        return list;
    }
    
    public Boolean modificarProducto(Producto prod) throws Exception
    {
        boolean respuesta = false;
        try
        {
            this.conectar();
            String sql = "call modificarProducto(?,?,?,?,?,?);";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, prod.getCodigoProducto());
            pre.setString(2, prod.getNombreProducto());
            pre.setDouble(3, prod.getPrecioVenta());
            pre.setInt(4, prod.getStockMinimo());
            pre.setInt(5, prod.getStockActual());
            pre.setString(6, prod.getCodigoBarra());
            int res = pre.executeUpdate();
            if(res>0)
            {
                respuesta = true;
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        return respuesta;
    }
    
    public boolean eliminarProducto(int idProd) throws Exception
    {
        boolean respuesta = false;
        try
        {
            this.conectar();
            String sql = "call eliminarProducto(?);";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, idProd);
            int res = pre.executeUpdate();
            if(res>0)
            {
                respuesta = true;
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        return respuesta;
    }
    
    public void eliminadoLogicoProducto(Producto prod) throws Exception
    {
        try
        {
            this.conectar();
            String sql = "call eliminadoLogicoProducto(?);";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, prod.getCodigoProducto());
            pre.executeUpdate();
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
    }
    
    public List<Producto> buscarNombreProducto(String s) throws Exception
    {
        ResultSet res;
        List<Producto> list = new ArrayList();
        try 
        {
            this.conectar();
            String sql = "call buscarNombreProducto(?);";
            PreparedStatement pre = this.getCon().prepareCall(sql);
            pre.setString(1, s);
            res = pre.executeQuery();
            Producto prod;
            while(res.next())
            {
                prod = new Producto(res.getInt("codigoProducto"), res.getString("nombreProducto"), res.getDouble("precioVenta"), res.getInt("stockMinimo"), res.getInt("stockActual"), res.getString("codigoBarra"));
                list.add(prod);
            }
        } 
        catch (Exception e) 
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        return list;
    }
    
    public String buscarIDProducto(int i) throws Exception
    {
        ResultSet res;
        String json = "";
        try 
        {
            this.conectar();
            String sql = "call buscarIDProducto(?);";
            PreparedStatement pre = this.getCon().prepareCall(sql);
            pre.setInt(1, i);
            res = pre.executeQuery();
            res.next();
            
            json = "{"
                    + "\"nombreProducto\" : \""+res.getString("nombreProducto").replaceAll("\"","\\\\\"")+"\","
                    + "\"precioVenta\" : \""+res.getDouble("precioVenta")+"\","
                    + "\"stockMinimo\" : \""+res.getInt("stockMinimo")+"\","
                    + "\"stockActual\" : \""+res.getInt("stockActual")+"\""
                    +"}";
        } 
        catch (Exception e) 
        {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        return json;
    }
}
