<%-- 
    Document   : ticket
    Created on : 10-01-2018, 09:04:56 PM
    Author     : rocke
--%>

<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="com.modelo.Factura"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="com.dao.DaoFactura"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DaoFactura daoF = new DaoFactura();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ticket</title>
    </head>
    <body>
        <h1>Ticket</h1>
        
        <%
    if(request.getSession().getAttribute("nfactura")!=null){
        daoF.conectar();
        
        int n= Integer.parseInt(request.getSession().getAttribute("nfactura").toString());
        Factura fact = daoF.datosFactura(n);
        
        File reporte = new File(application.getRealPath("reportes/ticketCompra.jasper"));
        Map parametros = new HashMap();
        parametros.put("cliente", fact.getNombreCliente());
        parametros.put("fecha", fact.getFecha());
        parametros.put("nfactura", n);
        parametros.put("total", fact.getTotal());
        parametros.put("totalIVA", fact.getTotalIVA());
        parametros.put("vendedor", fact.getNombreVendedor());
        
        byte[] bytes = JasperRunManager.runReportToPdf(reporte.getPath(), parametros,daoF.getCon());
        
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        
        ServletOutputStream output= response.getOutputStream();

        response.getOutputStream();
        output.write(bytes,0,bytes.length);
        output.flush();
    }else{%>
    <script>window.close();</script>
    <%}%>
        
        
    </body>
</html>
