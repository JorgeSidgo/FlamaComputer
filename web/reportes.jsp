<%-- 
    Document   : reportes
    Created on : 10-03-2018, 04:41:22 PM
    Author     : jsidg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>

<div id="app">
    <div class="ui grid">
        <div class="row">
            <div class="titulo">
                Reportes
            </div>
        </div>

        <!-- Reporte de rango de fechas -->
        <div class="row">
            <div class="ui fluid segment" style="width: 100%;">
                <h4 class="ui dividing header">Facturas comprendidas:</h4>
                <form action="" class="ui form" style="width: 50%;">
                    <div class="field">
                        <label>Desde:</label>
                        <input type="date" name="first-name" placeholder="First Name">
                      </div>
                      <div class="field">
                        <label>Hasta:</label>
                        <input type="date" name="last-name" placeholder="Last Name">
                      </div>
                      <button class="ui green button" type="submit">Generar</button>
                </form>
            </div>
        </div>


    </div>
</div>

<script>
    var app = new Vue({
        el: "#app",
        data: {},
        methods: {}

    });
</script>