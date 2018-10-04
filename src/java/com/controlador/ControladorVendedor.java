package com.controlador;

import com.dao.DaoVendedor;
import com.google.gson.*;
import com.modelo.Vendedor;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author franc
 */
public class ControladorVendedor extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession sesion = request.getSession();
        RequestDispatcher rd = null;
        Vendedor ve = new Vendedor();
        DaoVendedor daoV = new DaoVendedor();
        String msj = "";
        String op = "";
        
        try
        {
            if (request.getParameter("operacion") != null)
            {
                op = request.getParameter("operacion");
            }
            
            switch(op)
            {
                case "tablaVendedores":
                     String json = daoV.mostrarVendedor();
                     out.print(json);
                    break;
                
                case "insertarVendedor":
                    boolean estado = false;
                    
                    JsonParser parser = new JsonParser();
                    JsonArray datos = parser.parse(request.getParameter("datos")).getAsJsonArray();
                    
                    JsonElement elemento= datos.get(0);
                    JsonObject objeto = elemento.getAsJsonObject();
                    ve.setNombre(objeto.get("value").getAsString());
                    
                    elemento= datos.get(1);
                    objeto = elemento.getAsJsonObject();
                    ve.setApellido(objeto.get("value").getAsString());
                    
                    elemento= datos.get(2);
                    objeto = elemento.getAsJsonObject();
                    ve.setDui(objeto.get("value").getAsString());
                    
                    elemento= datos.get(3);
                    objeto = elemento.getAsJsonObject();
                    ve.setDirecciones(objeto.get("value").getAsString());
                    
                    elemento= datos.get(4);
                    objeto = elemento.getAsJsonObject();
                    ve.setTelMov(objeto.get("value").getAsString());
                    
                    elemento = datos.get(5);
                    objeto = elemento.getAsJsonObject();
                    ve.setTelOficina(objeto.get("value").getAsString());
                    
                    estado = daoV.insertarVendedor(ve);
                  
                    break;
            }
        }
        catch (Exception e) 
        {
            out.print("Exception Controlador Vendedores" + e.getMessage());
        }
        
        out.print(msj);
        
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
