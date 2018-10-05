<%-- 
    Document   : clientes
    Created on : 10-03-2018, 04:47:00 PM
    Author     : jsidg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>

<div id="app">
    <div class="ui grid">
        <div class="row">
            <div class="titulo">
                Clientes
            </div>
        </div>
        <div class="row">
            <div class="sixteen wide column">
                <table id="dtClientes" class="ui selectable very compact celled table" style="width:100%; margin:auto;">
                    <thead>
                        <tr>
                            <th>codigoCliente</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Direccion</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="tablas/tablaClientes.js"></script>

<script>
    var app = new Vue({
        el: "#app",
        data: {},
        methods: {}

    });
</script>