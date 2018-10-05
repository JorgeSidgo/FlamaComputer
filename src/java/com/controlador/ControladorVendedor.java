package com.controlador;

import com.dao.DaoUsuario;
import com.dao.DaoVendedor;
import com.google.gson.*;
import com.modelo.Usuario;
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
        Usuario u = new Usuario();
        DaoUsuario daoU = new DaoUsuario();
        DaoVendedor daoV = new DaoVendedor();
        String msj = "";
        String op = "";
        int dlt = 0;
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
                    int estado = 0;
                    
                    JsonParser parser = new JsonParser();
                    JsonArray datos = parser.parse(request.getParameter("datos")).getAsJsonArray();
                    
                    JsonElement elemento= datos.get(0);
                    JsonObject objeto = elemento.getAsJsonObject();
                    u.setNombreUsuario(objeto.get("value").getAsString());
                    
                    elemento= datos.get(1);
                    objeto = elemento.getAsJsonObject();
                    u.setPass(objeto.get("value").getAsString());
                    u.setCodigoRol(3);
                    
                    daoU.registrarUsuario(u);
                    
                    elemento= datos.get(2);
                    objeto = elemento.getAsJsonObject();
                    ve.setNombre(objeto.get("value").getAsString());
                    
                    elemento= datos.get(3);
                    objeto = elemento.getAsJsonObject();
                    ve.setApellido(objeto.get("value").getAsString());
                    
                    elemento= datos.get(4);
                    objeto = elemento.getAsJsonObject();
                    ve.setDui(objeto.get("value").getAsString());
                    
                    elemento= datos.get(5);
                    objeto = elemento.getAsJsonObject();
                    ve.setDirecciones(objeto.get("value").getAsString());
                    
                    elemento= datos.get(6);
                    objeto = elemento.getAsJsonObject();
                    ve.setTelMov(objeto.get("value").getAsString());
                    
                    elemento = datos.get(7);
                    objeto = elemento.getAsJsonObject();
                    ve.setTelOficina(objeto.get("value").getAsString());
                    
                    ve.setCodigoUsuario(daoU.lastId());
                    
                    estado = daoV.insertarVendedor(ve);
                    out.print(estado);
                    break;
                    
                case "modificarVendedor":
                     int res = 0;
                    
                    JsonParser p = new JsonParser();
                    JsonArray d = p.parse(request.getParameter("datos")).getAsJsonArray();
                    
                    JsonElement el = d.get(0);
                    JsonObject ob = el.getAsJsonObject();
                    ve.setCodigoVendedor(ob.get("value").getAsInt());
                    
                    el = d.get(1);
                    ob = el.getAsJsonObject();
                    ve.setNombre(ob.get("value").getAsString());
                    
                    el= d.get(2);
                    ob = el.getAsJsonObject();
                    ve.setApellido(ob.get("value").getAsString());
                    
                    el= d.get(3);
                    ob = el.getAsJsonObject();
                    ve.setDui(ob.get("value").getAsString());
                    
                    el= d.get(4);
                    ob = el.getAsJsonObject();
                    ve.setDirecciones(ob.get("value").getAsString());
                    
                    el= d.get(5);
                    ob = el.getAsJsonObject();
                    ve.setTelMov(ob.get("value").getAsString());
                    
                    el = d.get(6);
                    ob = el.getAsJsonObject();
                    ve.setTelOficina(ob.get("value").getAsString());
                    
                    res = daoV.modificarVendedor(ve);
                    out.print(res);
                    break;
                    
                case "eliminarVendedor":
                    int id = 0;
                    if (request.getParameter("dato")!=null) {
                         id = Integer.parseInt(request.getParameter("dato"));
                    }
                        dlt = daoV.eliminarVendedor(id,  2);
                       out.print(dlt);
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
