<%-- 
    Document   : clientesSistema
    Created on : 10-05-2018, 12:17:40 PM
    Author     : jsidg
--%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="com.conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clientes Registrados</title>
    </head>
    <body>
        <%
            Conexion con = new Conexion();
            con.conectar();
            File reporte  = new File(application.getRealPath("reportes/clientesRegistrados.jasper"));
            Map parametros = new HashMap();
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
