/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controlador;

import com.dao.DaoProducto;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import com.modelo.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ramirez
 */
public class ControladorProductos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        DaoProducto dao = new DaoProducto();
        Producto p = new Producto();
        String op="";
        try {
            if (request.getParameter("operacion") != null)
            {
                op = request.getParameter("operacion");
            }
            switch (op)
            {
                case "registrar":
                    JsonParser parser = new JsonParser();
                    JsonObject objeto = parser.parse(request.getParameter("datos")).getAsJsonObject();
                    
                    p.setNombreProducto(objeto.get("nombreProducto").getAsString());
                    p.setPrecioVenta(objeto.get("precioVenta").getAsDouble());
                    p.setStockMinimo(objeto.get("stockMinimo").getAsInt());
                    p.setStockActual(objeto.get("stockActual").getAsInt());
                    //p.setCodigoBarra(objeto.get("codigoBarra").getAsString());
                    
                    if(dao.insertarProducto(p))
                    {
                        out.print("1");
                    }
                    else
                    {
                        out.print("2");
                    }
                    break;
                case "tablaProductos":
                    String json =  dao.mostrarProducto();
                    out.print(json);
                    break;
                case "eliminar":
                    int id = Integer.parseInt(request.getParameter("id"));
                    if(dao.eliminarProducto(id))
                    {
                        out.print("1");
                    }
                    else
                    {
                        out.print("2");
                    }
                    break;
                case "editar":
                    JsonParser parser2 = new JsonParser();
                    JsonObject objeto2 = parser2.parse(request.getParameter("datos")).getAsJsonObject();
                    
                    p.setCodigoProducto(objeto2.get("codigoProducto").getAsInt());
                    p.setNombreProducto(objeto2.get("nombreProducto").getAsString());
                    p.setPrecioVenta(objeto2.get("precioVenta").getAsDouble());
                    p.setStockMinimo(objeto2.get("stockMinimo").getAsInt());
                    p.setStockActual(objeto2.get("stockActual").getAsInt());
                    p.setCodigoBarra(null);
                    
                    if(dao.modificarProducto(p))
                    {
                        out.print("1");
                    }
                    else
                    {
                        out.print("2");
                    }
                    break;    
                case "getProducto":
                        
                    int codigo = Integer.parseInt(request.getParameter("id"));
                    
                    String cosa = dao.buscarIDProducto(codigo);
                    out.print(cosa);
                    
                    break;
                default:
                    break;
            }
        }
        catch(Exception e){
            out.print("Exception en Producto " + e.getMessage());
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
            throws ServletException, IOException {
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
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
