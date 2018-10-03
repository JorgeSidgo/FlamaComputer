/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controlador;

import com.dao.DaoFactura;
import com.google.gson.*;
import com.modelo.DetalleFactura;
import com.modelo.Factura;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jsidg
 */
public class ControladorFactura extends HttpServlet
{

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter())
        {

            DaoFactura daoF= new DaoFactura();

            if(request.getParameter("op")!=null){
                String op=request.getParameter("op");
                if(op.equals("1")){
                    
                
                    JsonParser parser = new JsonParser();
                    JsonObject objeto = parser.parse(request.getParameter("datos")).getAsJsonObject();
    //                JSON ejemplo
    //                datos= {
    //                    nfactura:2,
    //                    vendedor:1,
    //                    cliente: 2
    //                    total:1.0
    //                    totalIVA: 1.13
    //                    detalle[
    //                        {id:1, producto:'churrito', precio:0.10, cantidad:1},
    //                        {id:12, producto:'elotito', precio:0.10, cantidad:3},
    //                        {id:13, producto:'quisitrix', precio:0.25, cantidad:2}
    //                    ]
    //            };


    //                OBTIENE CADA VALOR PRIMITIVO DEL JSON
                    Factura fact = new Factura();
                    fact.setNumero(objeto.get("nfactura").getAsInt());
                    fact.setVendedor(objeto.get("vendedor").getAsInt());
                    fact.setCliente(objeto.get("cliente").getAsInt());
                    fact.setTotal(objeto.get("total").getAsDouble());
                    fact.setTotalIVA(objeto.get("totalIVA").getAsDouble());
                    request.getSession().setAttribute("efectivo", objeto.get("efectivo").getAsString());
                    request.getSession().setAttribute("cambio", objeto.get("cambio").getAsString());
                    
                    //OBTIENE CADA OBJETO DE LA PROPIEDAD TIPO ARRAY "DETALLE"  DEL JSON
                    JsonArray detalle = objeto.get("detalle").getAsJsonArray();
                    List <DetalleFactura> fila= new ArrayList();
                    
                    for (JsonElement elemento : detalle)
                    {
                        JsonObject registro = elemento.getAsJsonObject();
                        DetalleFactura regDetalle= new DetalleFactura();

                        regDetalle.setCodigoProducto(registro.get("id").getAsInt());
                        regDetalle.setCantidad(registro.get("cantidad").getAsInt());

    //                    SUBTOTAL
                        regDetalle.setTotal(
                                registro.get("precio").getAsDouble()*regDetalle.getCantidad()
                        );

                        fila.add(regDetalle);
                    }
                    
                    daoF.insertar(fact, fila);
                    
                }else if(op.equals("2")){
//                    mostrar reporte
                    int n=Integer.parseInt(request.getParameter("nfactura"));
                    request.getSession().setAttribute("nfactura", n);
                    
                    response.sendRedirect("ticket.jsp");
                }
            }

        }
        catch(Exception e){
            System.out.print("error: "+e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo()
    {
        return "Short description";
    }// </editor-fold>

}
