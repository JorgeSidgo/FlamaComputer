<%-- 
    Document   : login
    Created on : 09-16-2018, 09:14:38 PM
    Author     : jsidg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <link href="res/semantic/semantic.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="res/Material-Icons/material-icons.css">

    <script src="res/jquery/jquery.js" type="text/javascript"></script>
    <script src="res/vue/vue.js"></script>
    <script src="res/semantic/semantic.min.js" type="text/javascript"></script>
    <script src="res/js/efectinis.js"></script>
    <script src="res/js/menu.js"></script>
    <script src="res/js/validar.js"></script>

    <link rel="stylesheet" href="res/plugins/ripple/ripple.css">
    <script src="res/plugins/ripple/ripple.js"></script>
    <script src="res/plugins/ripple/ripple.init.js"></script>

</head>

<body class="body-login">
    <div id="app">
        <div class="contenedor" style="margin-top:0; height: 100vh; background: none !important; display: flex;
        align-items: center;
        justify-content: center;">
            <div class="cuadro" style="min-width: 350px">
                <div class="cuadro-ins">
                    <img src="res/img/svgComp.svg" alt="" id="logo-login">
                </div>
                <form action="" method="POST" class="ui form">
                    <div class="field">
                        <div class="ui left icon input">
                            <i class="user icon"></i>
                            <input @keyup.enter="login" @keyup="setTrue" type="text" class="reqLogin" name="user" id="user" placeholder="Usuario">
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui left icon input">
                            <i class="lock icon"></i>
                            <input type="password" class="reqLogin" name="pass" id="pass" placeholder="Contraseña"
                                @keyup.enter="login" @keyup="setTrue">
                        </div>
                    </div>
                    <div class="ui negative message" v-if="isError">
                        <p>
                            Datos Incorrectos
                        </p>
                    </div>
                    <button :class="loading" @click="login" id="btnLogin" type="button"
                        @submit.prevent="" >Ingresar</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        $(function () {
            $('#user').focus();
        });
    </script>
    

    <script>
        var app = new Vue({
            el: "#app",
            data: {
                isError: false,
                loading:['ui','fluid','dark-grey','button']
            },
            methods: {
                setTrue() {
                    this.isError = false;
                },
                login() {
                    this.loading.push('loading');
                    var user = document.getElementById("user").value.trim();
                    var pass = document.getElementById("pass").value.trim();

                    /* $('#btnLogin').addClass("loading"); */

                    fetch("controladorUsuario?operacion=login&user="+ user + "&pass=" + pass)
                        .then(response => {
                            if (response.ok) {
                                return response.json();
                            } else {
                                throw "Error al recibir datos";
                                this.isError = true;
                                
                            }
                        })
                        .then(val => {

                            if (val == 1) {
                                location.href = 'dashboard.jsp';
                                
                            } else {
                                this.loading.pop();
                                this.isError = true;
                            }
                            
                        }).catch(res => {
                            this.loading.pop();
                            this.isError = true;
                            console.log(res);
                        
                        });
                }
            }
        });
    </script>
</body>

</html>
