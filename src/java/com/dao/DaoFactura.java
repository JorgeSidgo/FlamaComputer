package com.dao;

import com.conexion.Conexion;
import com.modelo.DetalleFactura;
import com.modelo.Factura;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

/**
 *
 * @author rocke
 */
public class DaoFactura extends Conexion
{
    public int numeroFactura() throws Exception{
        int n=0;
        try
        {
            this.conectar();
            String sql="select IFNULL(max(codigoFactura)+1,1) as n from factura";
            PreparedStatement query = this.getCon().prepareStatement(sql);
            ResultSet set = query.executeQuery();
            while(set.next()){
                n=set.getInt(1);
            }
            
        } 
        catch (Exception e)
        {
            System.out.print("error al mostrar numero factura"+ e.getMessage());
        }finally{
            this.desconectar();
        }
        return n;
    }
    
//    public void insertar(Factura fact) throws Exception{
    public void insertar(Factura fact, List<DetalleFactura> detalle) throws Exception{
        try
        {
            this.conectar();
            
            
            String sqlFactura="call nuevaFactura(?,?,?,?,?)";
            PreparedStatement pre= this.getCon().prepareCall(sqlFactura);
            pre.setInt(1, fact.getNumero());
            pre.setInt(2, fact.getVendedor());
            pre.setInt(3, fact.getCliente());
            pre.setDouble(4, fact.getTotal());
            pre.setDouble(5,fact.getTotalIVA());
//            pre.setString(6,fact.getFecha());
            pre.execute();
            
            String sqlDetalle="call detalleFactura(?, ?, ?, ?)";
            String sqlRestar= "call restarStock(?,?)";
            for (DetalleFactura detalleFactura : detalle)
            {
                PreparedStatement pre2= this.getCon().prepareCall(sqlDetalle);
                pre2.setInt(1, fact.getNumero());
                pre2.setInt(2, detalleFactura.getCodigoProducto());
                pre2.setInt(3, detalleFactura.getCantidad());
                pre2.setDouble(4, detalleFactura.getTotal());
                pre2.execute();
                
                PreparedStatement pre3 = this.getCon().prepareCall(sqlRestar);
                pre3.setInt(1, detalleFactura.getCodigoProducto());
                pre3.setInt(2, detalleFactura.getCantidad());
                pre3.execute();
                
            }
            
        } catch (Exception e)
        {
            System.out.print("Error al registrar factura: "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
    }
    
    public Factura datosFactura(String codigo) throws Exception{
        Factura fact = new Factura();
        try
        {
            this.conectar();
            
            String sql="call buscarFactura(?)";
            PreparedStatement pre = this.getCon().prepareCall(sql);
            pre.setString(1, codigo);
            
            ResultSet res = pre.executeQuery();
            while(res.next()){
                fact.setNumero(res.getInt(1));
                fact.setNombreVendedor(res.getString(2));
                fact.setNombreCliente(res.getString(3));
                fact.setTotal(res.getDouble(4));
                fact.setTotalIVA(res.getDouble(5));
                fact.setFecha(res.getString(6));
            }
            
        } 
        catch (Exception e)
        {
            System.out.print("Error al buscar datos de factura: "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        
        return fact;
    }
}
