package com.dao;

import com.conexion.Conexion;
import com.modelo.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Nombre de la Clase: DaoUsuario 
 * Version: 1.0 
 * Fecha: 17/09/2018
 * @author Jorge Sidgo-Pimentel
 */

public class DaoUsuario extends Conexion
{

    public static int idUsuario;
    public static String nombreUsuario;
    public static String permisos;
    public static int idPermiso;
    public static String descRol;
    public static int idVendedor;
    

    public String getNomUsuario(int id) throws Exception
    {
        String nombre = "";
        
        try {
            this.conectar();
            String sql = "select nombreUsuario from usuario where codigoUsuario = ?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet res = pre.executeQuery();
            res.next();
            nombre = res.getString(1);
        } catch (Exception e) {
            throw e;
        }
        finally
        {
            this.desconectar();
        }
        
        return nombre;
    }
    
    public String getUsuarioId(int id) throws Exception
    {
        String json = "";
        
        try
        {
            this.conectar();
            String sql = "call getUsuarioId(?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);            
            pre.setInt(1, id);
            ResultSet res = pre.executeQuery();
            res.next();
            
            json = "{"
                    + "\"nombreUsuario\" : \""+ res.getString("nombreUsuario") +"\", "
                    + "\"codigoRol\": \"" + res.getInt("codigoRol") + "\""
                    + "}";
            
            
            
        } catch (Exception e)
        {
            System.out.print(e.getMessage());
            throw e;
        }
        finally 
        {
            this.desconectar();
        }
        
        return json;
    }
    
    public boolean compNombre(String nombre) throws Exception
    {
        boolean respuesta = false;

        try
        {
            this.conectar();
            String sql = "call compNombreUsuario(?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);

            pre.setString(1, nombre);
            
            ResultSet res = pre.executeQuery();
            
            res.next();
            
            if(res.getInt("numero") == 0)
            {
                respuesta = true;
            }

        } catch (Exception e)
        {
            System.out.print(e.getMessage());
            throw e;
        } finally
        {
            this.desconectar();
        }

        return respuesta;
    }
    
    public boolean registrarUsuario(Usuario u) throws Exception
    {
        boolean respuesta = false;

        try
        {
            this.conectar();
            String sql = "call registrarUsuario(?,?,?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);

            pre.setString(1, u.getNombreUsuario());
            pre.setString(2, u.getPass());
            pre.setInt(3, u.getCodigoRol());

            int res = pre.executeUpdate();
            
            if(res > 0)
            {
                respuesta = true;
            }

        } catch (Exception e)
        {
            System.out.print(e.getMessage());
            throw e;
        } finally
        {
            this.desconectar();
        }

        return respuesta;
    }
    
    public boolean editarUsuario(Usuario u) throws Exception
    {
        boolean respuesta = false;

        try
        {
            this.conectar();
            String sql = "call editarUsuario(?,?,?,?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);

            pre.setString(1, u.getNombreUsuario());
            pre.setString(2, u.getPass());
            pre.setInt(3, u.getCodigoRol());
            pre.setInt(4, u.getCodigoUsuario());

            int res = pre.executeUpdate();
            
            if(res > 0)
            {
                respuesta = true;
            }

        } catch (Exception e)
        {
            System.out.print(e.getMessage());
            throw e;
        } finally
        {
            this.desconectar();
        }

        return respuesta;
    }

    public String mostrarUsuarios() throws Exception
    {
        String usuarios = "";
        DaoRol daoR = new DaoRol();
        try
        {
            this.conectar();
            String sql = "select * from v_usuarios";
            PreparedStatement pre = this.getCon().prepareStatement(sql);

            ResultSet res = pre.executeQuery();

            while (res.next())
            {
                String eliminar = "";
                String editar = "";
                    
                if(res.getInt("codigoRol") == 1){}
                else if (res.getInt("codigoRol") == 3) {
                    editar = "<button id=\\\"" + res.getInt("codigoUsuario") + "\\\"  class=\\\"ui btnEditar icon primary small button\\\"><i class=\\\"edit icon\\\"></i></button>";
                    eliminar = "";
                }
                else {
                    editar = "<button id=\\\"" + res.getInt("codigoUsuario") + "\\\"  class=\\\"ui btnEditar icon primary small button\\\"><i class=\\\"edit icon\\\"></i></button>";
                    eliminar = "<button id=\\\"" + res.getInt("codigoUsuario") + "\\\" @click=\\\"modalEliminar\\\" class=\\\"ui btnEliminar icon negative small button\\\"><i class=\\\"trash icon\\\"></i></button>";
                }

                usuarios += "{\n"
                        + "\"idUsuario\": \"" + res.getInt("codigoUsuario") + "\", "
                        + "\"Nombre de Usuario\": \"" + res.getString("nombreUsuario") + "\", "
                        + "\"Permisos\": \"" + daoR.returnRol(res.getInt("codigoRol")) + "\", "
                        + "\"Acciones\": \""+ editar + " " + eliminar + "\""
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
    
    public boolean eliminarUsuario(int id) throws Exception
    {
        boolean respuesta = false;
        
        try
        {
            this.conectar();
            String sql = "call eliminarUsuario(?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);

            pre.setInt(1, id);

            int res = pre.executeUpdate();
            
            if(res > 0)
            {
                respuesta = true;
            }

        } catch (Exception e)
        {
            System.out.print(e.getMessage());
            throw e;
        } finally
        {
            this.desconectar();
        }
        
        return respuesta;
    }
    
    public int lastId() throws Exception
    {
        int id = 0;
        
        try
        {
            this.conectar();
            String sql = "select max(codigoUsuario) as id from usuario;";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            
            ResultSet res = pre.executeQuery();
            
            res.next();
            
            id = res.getInt("id");
            
        } catch (Exception e)
        {
            id = 1;
        }
        finally
        {
            this.desconectar();
        }
        
        return id;
    }

    public boolean login(Usuario u) throws Exception
    {
        DaoVendedor daoV = new DaoVendedor();
        boolean respuesta = false;
        int filas = 0;

        try
        {
            this.conectar();
            String sql = "call login(?, ?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);

            pre.setString(1, u.getNombreUsuario());
            pre.setString(2, u.getPass());

            ResultSet res = pre.executeQuery();

            res.last();
            filas = res.getRow();
            //res.beforeFirst();

            if (filas == 1)
            {
                DaoUsuario.idUsuario = res.getInt("codigoUsuario");
                DaoUsuario.nombreUsuario = res.getString("nombreUsuario");
                DaoUsuario.idPermiso = res.getInt("codigoRol");
                DaoUsuario.descRol = res.getString("descRol");
                
                if(res.getInt("codigoRol") == 3)
                {
                    DaoUsuario.idVendedor = daoV.codigoVendedorId(res.getInt("codigoUsuario"));
                }
                else{
                    DaoUsuario.idVendedor=0;
                }

                respuesta = true;
            } else
            {
                respuesta = false;
            }
        } catch (Exception e)
        {
            System.out.print(e.getMessage());
            throw e;
        } finally
        {
            this.desconectar();
        }

        return respuesta;

    }
}
