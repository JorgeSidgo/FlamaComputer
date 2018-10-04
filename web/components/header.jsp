<%@page session="true"%>
<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Flama Computer</title>
    <link rel="apple-touch-icon" sizes="76x76" href="res/fav/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="res/fav/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="res/fav/favicon-16x16.png">
    <link rel="manifest" href="res/fav/site.webmanifest">
    <link rel="mask-icon" href="res/fav/safari-pinned-tab.svg" color="#333333">
    <meta name="msapplication-TileColor" content="#fafafa">
    <meta name="theme-color" content="#fafafa">

    <link rel="stylesheet" href="res/css/main.css">
    <link rel="stylesheet" href="res/css/fonts.css">
    <link href="res/semantic/semantics.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="res/Material-Icons/material-icons.css">

    <script src="res/jquery/jquery.js" type="text/javascript"></script>
    <script src="res/vue/vue.js"></script>
    <script src="res/semantic/semantic.min.js" type="text/javascript"></script>
    <script src="res/js/efectinis.js"></script>
    <script src="res/js/menu.js"></script>
    <script src="res/js/validar.js"></script>

    <script src="res/plugins/sweetalert/sweetalert2.js" type="text/javascript"></script>
    <link href="res/plugins/sweetalert/sweetalert.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="res/plugins/ripple/ripple.css">
    <script src="res/plugins/ripple/ripple.js"></script>
    <script src="res/plugins/ripple/ripple.init.js"></script>

    <link rel="stylesheet" href="res/plugins/dataTable/dataTable.semantic.min.css">
    <script src="res/plugins/dataTable/dataTable.jquery.min.js"></script>
    <script src="res/plugins/dataTable/dataTable.semantic.min.js"></script>

    <!-- <script src="res/plugins/googleCharts/google-charts.js"></script> -->
    <!--<script src="res\plugins\googleCharts\google-charts.js"></script>-->

    <script>
         function HandleBackFunctionality()
        {
            /* if(window.event.) //Internet Explorer
            {
                try {
                    alert("Browser back button is clicked on Internet Explorer...");    
                } catch (error) {
                    alert(error);
                }
                
                window.stop();
            }
            else //Other browsers for example Chrome
            {
                try {
                    alert("Browser back button is clicked on other browser...");    
                } catch (error) {
                    alert(error);
                }
                
                window.stop();
            } */
        }

    </script>
</head>

<%
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    
    HttpSession sesion = request.getSession();
    int idUsuario=0;
    String nombreUsuario="";
    int idPermiso =0;
    String descRol = "";
    
    if(session.getAttribute("idUsuario")!=null){
         idUsuario = Integer.parseInt(String.valueOf(sesion.getAttribute("idUsuario")));
         nombreUsuario = String.valueOf(sesion.getAttribute("nombreUsuario"));
        idPermiso = Integer.parseInt(String.valueOf(sesion.getAttribute("idPermiso")));
         descRol = String.valueOf(sesion.getAttribute("descRol"));
    }else{
        response.sendRedirect("login.jsp");
    }
%>

<body onbeforeunload="HandleBackFunctionality()">
    <%@include file="menu.jsp" %>
    <%@include file="headerBar.jsp" %>
    <div class="pusher">
        <div class="contenedor">