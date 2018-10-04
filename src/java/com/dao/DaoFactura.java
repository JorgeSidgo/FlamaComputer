package com.dao;

import com.conexion.Conexion;
import com.modelo.Cliente;
import com.modelo.DetalleFactura;
import com.modelo.Factura;
import com.modelo.GraficaDatos;
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
    
    public int numeroCliente() throws Exception{
        int res= 0;
        try
        {
            this.conectar();
            
            
            String sql="select IFNULL(max(codigoCliente)+1,1) as n from cliente";
            PreparedStatement pre= this.getCon().prepareStatement(sql);
            ResultSet resultset=pre.executeQuery();
            
            while(resultset.next()){
                res=resultset.getInt(1);
            }
            
        } catch (Exception e)
        {
            System.out.print("error al conseguir numero clieten"+e.getMessage());
        }finally
        {
            this.desconectar();
        }
        return res;
    }
    
//    public void insertar(Factura fact) throws Exception{
    public int insertar(Cliente cliente, Factura fact, List<DetalleFactura> detalle) throws Exception{
        
            int result=0;
        try
        {
            this.conectar();
            
//            INSERTAR CLIENTE
            String sqlCliente = "call insertarCliente(?, ?, ?)";
            PreparedStatement preCliente= this.getCon().prepareCall(sqlCliente);
            preCliente.setString(1, cliente.getNombre());
            preCliente.setString(2, cliente.getApellidos());
            preCliente.setString(3, cliente.getDireccion());
            result=preCliente.executeUpdate();
            result=0;
            
//INSERTAR FACTURA            
            String sqlFactura="call nuevaFactura(?,?,?,?,?)";
            PreparedStatement pre= this.getCon().prepareCall(sqlFactura);
            pre.setInt(1, fact.getNumero());
            pre.setInt(2, fact.getVendedor());
            pre.setInt(3, fact.getCliente());
            pre.setDouble(4, fact.getTotal());
            pre.setDouble(5,fact.getTotalIVA());
            result=pre.executeUpdate();        //CAPTURAR RESULTADO DE LA CONSULTA
 
//INSERTAR CADA REGSITRO DEL DETALLE FACTURA            
            String sqlDetalle="call detalleFactura(?, ?, ?, ?)";
            String sqlRestar= "call restarStock(?,?)";
            for (DetalleFactura detalleFactura : detalle)
            {
//                INSERTA EN DETALLE FACTURA
                PreparedStatement pre2= this.getCon().prepareCall(sqlDetalle);
                pre2.setInt(1, fact.getNumero());
                pre2.setInt(2, detalleFactura.getCodigoProducto());
                pre2.setInt(3, detalleFactura.getCantidad());
                pre2.setDouble(4, detalleFactura.getTotal());
                result=pre2.executeUpdate();
                
//                RESTA PRODUCTO AL STOCK
                PreparedStatement pre3 = this.getCon().prepareCall(sqlRestar);
                pre3.setInt(1, detalleFactura.getCodigoProducto());
                pre3.setInt(2, detalleFactura.getCantidad());
                result=pre3.executeUpdate();
                
            }
            
        } catch (Exception e)
        {
            System.out.print("Error al registrar factura: "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        
        return result;
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
    
    public List<GraficaDatos> graficaVentasMes () throws Exception{
        List<GraficaDatos> datos=new ArrayList();
        try
        {
            this.conectar();
            String sql="call grafica1()";
            PreparedStatement  pres = this.getCon().prepareStatement(sql);
            ResultSet res= pres.executeQuery();
            
            while(res.next()){
                GraficaDatos data= new GraficaDatos();
                
                data.setCantidad(res.getInt(1));
                data.setNombreMes(res.getString(2) );
                
                datos.add(data);
            }
            
        } catch (Exception e)
        {
            
        }
        finally{
            this.desconectar();
        }
        
        return datos;
    }
}

