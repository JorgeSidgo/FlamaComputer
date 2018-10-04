<%-- 
    Document   : reporteRango
    Created on : 10-03-2018, 09:11:43 PM
    Author     : jsidg
--%>

<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="com.conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
            Conexion con = new Conexion();
            String init;
            String fin;
            File reporte = new File(application.getRealPath("facturasRango.jasper"));
            if((request.getParameter("init")) != null && (request.getParameter("fin") != null))
            {
                init = request.getParameter("init");
                fin = request.getParameter("fin");
            }
            else
            {
                init = "";
                fin = "";
            };
            Map parametros = new HashMap();
            con.conectar();
            parametros.put("init", init);
            parametros.put("fin", fin);
            byte[] bytes = JasperRunManager.runReportToPdf(reporte.getPath(), parametros, con.getCon());
            
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream output = response.getOutputStream();
            response.getOutputStream();
            output.write(bytes, 0, bytes.length);
            output.flush();
            output.close();
        %>