<div class="ui top fixed inverted menu borderless" id="barra">
    <a class="item" id="btn-menu">
        <i class="material-icons">menu</i>
    </a>
    <a class="item" id="logo-header">
        <img src="res/img/svg.svg" alt="" width="" class="logo" id="">
    </a>
    <div style="margin-right:10px;" id="tug" class="ui floated right dropdown floating item">
        <img class="ui avatar image" src="res/img/userDef.png"> &nbsp;&nbsp; <%= nombreUsuario%>
        <i class="dropdown icon"></i>
        <div class="menu back-yellow">
            <div class="header lowercase" style="margin-top: 15px !important; margin-bottom: 7px !important;">
                <%= descRol%>
            </div>
            <div class="divider"></div>
            <a href="">
                <div class="item">
                    <i class="cog icon"></i>
                    Cuenta
                </div>
            </a>
            <a href="controladorUsuario?operacion=logout">
                <div style="color:#c0392b;" class="item">
                    <i class="power icon"></i>
                    Cerrar Sesi&oacute;n
                </div>
            </a>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('.ui.dropdown')
            .dropdown();
    });
</script>