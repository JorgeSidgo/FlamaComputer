<%-- 
    Document   : reportes
    Created on : 10-03-2018, 04:41:22 PM
    Author     : jsidg
--%>

<%@page import="com.modelo.GraficaDatos"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.DaoFactura"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<div id="app">
    <div class="ui grid">
        <div class="row">
            <div class="titulo">
                Reportes
            </div>
        </div>
        <div class="row">
            <div class="ui fluid segment" style="width: 100%;">
                <h4 class="ui dividing header">Reportes de Productos</h4>
                <div class="ui four item menu">
                    <a href="reporteProductos.jsp" target="_blank" class="active item">Productos del Sistema</a>
                    <a href="reportePMVendidos.jsp" target="_blank" class="item">Productos Mas Vendidos</a>
                    <a href="vendedorVentas.jsp" target="_blank" class="item">Vendedor con más ventas</a>
                    <a href="clientesSistema.jsp" target="_blank" class="item">Clientes en el Sistema</a>
                </div>
            </div>
        </div>

          <div class="row">
            <div class="ui fluid segment" style="width: 100%;">
                <h4 class="ui dividing header">Ventas divididas por fechas</h4>
                <div id="grafica1">
                
                </div>
            </div>
        </div>
        <!-- Reporte de rango de fechas -->
        <div class="row">
            <div class="ui fluid segment" style="width: 100%;">
                <h4 class="ui dividing header">Facturas comprendidas:</h4>
                <form action="reporteRango.jsp" method="POST" class="ui form" style="width: 50%;">
                    <div class="field">
                        <label>Desde:</label>
                        <input type="text" placeholder="AAAA-mm-dd" class="fecha" name="init">
                      </div>
                      <div class="field">
                        <label>Hasta:</label>
                        <input type="text" placeholder="AAAA-mm-dd" class="fecha" name="fin">
                      </div>
                      <button class="ui green button" name="btnEnviar" type="submit" value="Papu">Generar</button>
                </form>
            </div>
        </div>
        
    </div>
</div>

<script>
    google.charts.load('current', {
            packages: ['corechart']
        });

    function drawChart() {
            // Define the chart to be drawn.
            var data = google.visualization.arrayToDataTable(
            [
                ['Mes','Cantidad'],
         <% 
                DaoFactura fact= new DaoFactura();
        
        List<GraficaDatos> data= fact.graficaVentasMes();
        for (GraficaDatos elem : data)
        {%>
                    ['<%= elem.getNombreMes()%>', <%= elem.getCantidad() %>],
        <%
                }
        %>
            ]);

            var options = {
                title: 'Ventas mensuales'
            };

            // Instantiate and draw the chart.
            var chart = new google.visualization.ColumnChart(document.getElementById('grafica1'));
            chart.draw(data, options);
        }
        google.charts.setOnLoadCallback(drawChart);
    
    var app = new Vue({
        el: "#app",
        data: { },
        methods: {}

    });
</script>