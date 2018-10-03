package com.controlador;

import com.dao.DaoUsuario;
import com.modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Collection;

/**
 * Nombre del Servlet: ControladorUsuario Version: 1.0 Fecha: 17/09/2018
 *
 * @authors Jorge Sidgo-Pimentel Benjamín Ramirez Abdiel Martinez Francisco
 * Montoya
 */
public class ControladorUsuario extends HttpServlet
{

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        HttpSession sesion = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        RequestDispatcher rd = null;
        Usuario u = new Usuario();
        DaoUsuario dao = new DaoUsuario();
        String msj = "";
        String op = "";

        try
        {
            if (request.getParameter("operacion") != null)
            {
                op = request.getParameter("operacion");
            }

            switch (op)
            {
                case "login":
                    u.setNombreUsuario(request.getParameter("user"));
                    u.setPass(request.getParameter("pass"));
                    if (dao.login(u))
                    {
                        sesion.setAttribute("idUsuario", DaoUsuario.idUsuario);
                        sesion.setAttribute("nombreUsuario", DaoUsuario.nombreUsuario);
                        sesion.setAttribute("idPermiso", DaoUsuario.idPermiso);
                        sesion.setAttribute("descRol", DaoUsuario.descRol);
                        out.print("1");
                    } else
                    {
                        out.print("2");
                    }
                    break;

                case "logout":
                    sesion.invalidate();
                    response.sendRedirect("login.jsp");
                    break;

                case "tablaUsuarios":
                    String json = dao.mostrarUsuarios();
                    out.print(json);
                    break;

                case "registrar":

                    JsonParser parser = new JsonParser();
                    JsonObject objeto = parser.parse(request.getParameter("datos")).getAsJsonObject();
                    
                    u.setNombreUsuario(objeto.get("nombreUsuario").getAsString());
                    u.setPass(objeto.get("pass").getAsString());
                    u.setCodigoRol(objeto.get("codigoRol").getAsInt());
                    

                    if(dao.registrarUsuario(u))
                    {
                        out.print("1");
                    }
                    else
                    {
                        out.print("2");
                    }
                    break;
                
                case "compContra":
                    
                    u.setNombreUsuario(request.getParameter("user"));
                    u.setPass(request.getParameter("pass"));
                    if (dao.login(u))
                    {
                        out.print("1");
                    } else
                    {
                        out.print("2");
                    }
                    
                    break;
                    
                case "getUsuario":
                        
                    int codigo = Integer.parseInt(request.getParameter("id"));
                    
                    String cosa = dao.getUsuarioId(codigo);
                    
                    out.print(cosa);
                    
                    break;
                    
                case "editar":

                    JsonParser parser2 = new JsonParser();
                    JsonObject objeto2 = parser2.parse(request.getParameter("datos")).getAsJsonObject();
                    
                    u.setCodigoUsuario(objeto2.get("codigoUsuario").getAsInt());
                    u.setNombreUsuario(objeto2.get("nombreUsuario").getAsString());
                    u.setPass(objeto2.get("pass").getAsString());
                    u.setCodigoRol(objeto2.get("codigoRol").getAsInt());
                    
                    if(dao.editarUsuario(u))
                    {
                        out.print("1");
                    }
                    else
                    {
                        out.print("2");
                    }
                    
                    break;
                    
                case "eliminar":
                    int id = Integer.parseInt(request.getParameter("id"));
                    if(dao.eliminarUsuario(id))
                    {
                        out.print("1");
                    }
                    else
                    {
                        out.print("2");
                    }
                    break;

                default:
                    break;
            }
        } catch (Exception e)
        {
            out.print("Exception en el login" + e.getMessage());
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
