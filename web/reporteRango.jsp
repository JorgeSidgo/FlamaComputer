<%-- 
    Document   : reporteProductos
    Created on : 05-oct-2018, 10:41:08
    Author     : jsidg
--%>

<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="com.conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Productos del Sistema</title>
    </head>
    <body>
        <h1></h1>
        <%
            Conexion con = new Conexion();
            con.conectar();
            File reporte  = new File(application.getRealPath("reportes/facturas.jasper"));
            Map parametros = new HashMap();
            String inicio = "";
            String fin = "";
            
            if(request.getParameter("btnEnviar") != null)
            {
                inicio = request.getParameter("init");
                fin = request.getParameter("fin");
            }
            parametros.put("fechaInit", inicio);
            parametros.put("fechaFin", fin);
            
            byte[] bytes = JasperRunManager.runReportToPdf(reporte.getPath(), parametros, con.getCon());
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream output = response.getOutputStream();
            response.getOutputStream();
            output.write(bytes, 0, bytes.length);
            output.flush();
            output.close();
        %>
    </body>
</html>
