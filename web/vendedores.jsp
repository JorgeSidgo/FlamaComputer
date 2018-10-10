<%-- 
    Document   : Vendedores
    Created on : 09-18-2018, 10:55:35 PM
    Author     : jsidg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>

<div class="ui grid">
    <div class="row">
        <div class="titulo">
            Vendedores
        </div>
    </div>
    <div class="row title-bar">
        <div class="sixteen wide column">
            <button class="ui right floated positive labeled icon button" id="btnModalRegistro"><i class="plus icon"></i>Registrar</button>
        </div>
        <!--Este es el modal de ingreso vendedor-->
        <div class="ui small modal" id="modalIngreso">
            <div class="header">
                Ingresar Vendedor
            </div>
            <div class="content" id="datosVendedor">
                <form method="get" class="ui form" id="frmIngreso">
                    <div class="field">
                        <div class="three fields">
                            <div class="field">
                                <label>Usuario:</label>
                                <input type="text" name="txtUsuarioV" placeholder="Usuario" class="requerido">
                                <div class="ui red pointing label" style="display: none;">
                                </div>
                            </div>
                            <div class="field">
                                <label>Contraseña:</label>
                                <input type="password" name="txtContraV" placeholder="Contraseña" class="requerido">
                                <div class="ui red pointing label" style="display: none;">
                                </div>
                            </div>
                            <div class="field">
                                <label>Confirmar contraseña:</label>
                                <input type="password" name="txtConfContraV" placeholder="Confirmar contraseña" class="requerido">
                                <div class="ui red pointing label" style="display: none;">
                                </div>
                            </div>
                        </div>
                        <div class="two fields">
                            <div class="field">
                                <label>Nombre</label>
                                <input type="text" name="txtNombreV" placeholder="Nombre" class="requerido">
                                <div class="ui red pointing label" style="display: none;"></div>
                            </div>
                            <div class="field">
                                <label>Apellido</label>
                                <input type="text" name="txtApellidoV" placeholder="Apellido" class="requerido">
                                <div class="ui red pointing label" style="display: none;"></div>
                            </div>
                            <div class="field">
                                <label>Numero de DUI</label>
                                <input type="text" class="dui requerido" name="txtDuiV" placeholder="Dui">
                                <div class="ui red pointing label" style="display: none;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <div class="two fields">
                            <div class="field">
                                <label>Dirección</label>
                                <input type="text" name="txtDireccionV" placeholder="Dirección" class="requerido">
                                <div class="ui red pointing label" style="display: none;"></div>
                            </div>
                            <div class="field">
                                <label>Telefono Movil</label>
                                <input type="text" name="txtTelMovilV" class="telefono requerido" placeholder="0000-0000">
                                <div class="ui red pointing label" style="display: none;"></div>
                            </div>
                            <div class="field">
                                <label>Telefono Oficina</label>
                                <input type="text" name="txtTelOfiV" class="telefono requerido" placeholder="0000-0000">
                                <div class="ui red pointing label" style="display: none;"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="actions">
                <button class="ui black deny button" id="btnCancelarReg">Cancelar</button>
                <button class="ui right button green" id="btnRegistrarV">Registrar</button>
            </div>
        </div>
        <!--Aqui termina el modal-->
    </div>
    <div class="row title-bar">
        <div class="sixteen wide column">
            <div class="ui divider"></div>
            <div>
                <div class="row">
                    <div class="sixteen wide column">
                        <table id="dtVendedores" class="ui selectable very compact celled table" style="width:100%; margin:auto;">
                            <thead>
                                <tr>
                                    <th>Codigo Vendedor</th>
                                    <th>Nombre de Usuario</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>DUI</th>
                                    <th>Dirección</th>
                                    <th>Telefono Oficina</th>
                                    <th>Telefono Movil</th>
                                    <th>Codigo Usuario</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!--Contenido-->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--Este es el modal de modificar vendedor-->
<div class="ui modal" id="modalModificar">
    <i class="close icon"></i>
    <div class="header">
        Modificar Vendedor
    </div>
    <div class="content" id="datosModificarV">
        <form method="get" class="ui form" id="frmModificar">
            <div class="field">
                <div class="two field">
                    <div class="field">
                        <label>Codigo Vendedor</label>
                        <input type="text" name="idVendedor" id="idV" placeholder="Codigo Vendedor" readonly="">
                    </div>
                </div>
                <div class="two fields">
                    <div class="field">
                        <label>Nombre</label>
                        <input type="text" name="txtNombreV" placeholder="Nombre" class="requerido">
                        <div class="ui red pointing label" style="display: none;"></div>
                    </div>
                    <div class="field">
                        <label>Apellido</label>
                        <input type="text" name="txtApellidoV" placeholder="Apellido" class="requerido">
                        <div class="ui red pointing label" style="display: none;"></div>
                    </div>
                    <div class="field">
                        <label>Numero de DUI</label>
                        <input type="text" name="txtDuiV" class="dui requerido" placeholder="Dui">
                        <div class="ui red pointing label" style="display: none;"></div>
                    </div>
                </div>
            </div>
            <div class="field">
                <div class="two fields">
                    <div class="field">
                        <label>Dirección</label>
                        <input type="text" name="txtDireccionV" placeholder="Dirección" class="requerido">
                        <div class="ui red pointing label" style="display: none;"></div>
                    </div>
                    <div class="field">
                        <label>Telefono Movil</label>
                        <input type="text" name="txtTelMovilV" class="telefono requerido" placeholder="0000-0000">
                        <div class="ui red pointing label" style="display: none;"></div>
                    </div>
                    <div class="field">
                        <label>Telefono Oficina</label>
                        <input type="text" name="txtTelOfiV" class="telefono requerido" placeholder="0000-0000">
                        <div class="ui red pointing label" style="display: none;"></div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="actions">
        <div class="ui black deny button">Cancelar</div>
        <button class="ui submit button green" id="btnEditarV">Registrar</button>
    </div>

</div>
<!--Aqui termina el modal-->
<script src="tablas/tablaVendedores.js"></script>


<script>
    $(document).ready(function () {
        $('#btnModalRegistro').click(function () {
            $('#modalIngreso').modal('setting', 'closable', false).modal('show');
        });

        $(document).on("click", "#btnRegistrarV", function () {
            var exp = validarVacios("frmIngreso", "btnRegistrarV");

            if (exp == 0) {
                var datosVendedor = JSON.stringify($('#frmIngreso :input').serializeArray());
                ingresarVendedor(datosVendedor);
            }
        });

        $(document).on("click", ".btnEditar", function () {
            resetFrm("frmModificar", "btnEditar");
            $('#modalModificar').modal('setting', 'closable', false).modal('show');
            var id = this.id;
            $("#idV").val(id);
        });

        $(document).on("click", "#btnEditarV", function () {
            var exp = validarVacios("frmModificar", "btnEditarV");
            console.log(exp);
            if (exp == 0) {
                swal({
                    title: 'Modificar Vendedor',
                    text: "¿Desea realizar esta modificación?",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Si, Modificar'
                }).then((result) => {
                    if (result.value) {
                        var datosVendedor = JSON.stringify($('#datosModificarV :input').serializeArray());
                        modificarVendedor(datosVendedor);
                    }
                })
            }
        });


        $(document).on("click", ".btnEliminar", function () {
            eliminarVendedor(this);
        });
    });
    /*Aqui termina el document ready*/

    // AJAX PARA INGRESO DE VENDEDOR
    function ingresarVendedor(datos) {
        var status;
        $.ajax({
            type: 'post',
            async: false,
            dataType: 'json',
            data: {
                datos: datos
            },
            url: 'ControladorVendedor?operacion=insertarVendedor',
            success: function (result) {
                if (result == 1) {
                    swal({
                        title: 'Estado del Registro',
                        text: 'El vendedor fue ingresado correctamente',
                        type: 'success',
                        timer: 1800
                    })
                    $('#modalIngreso').modal('hide');
                    tablaVendedores.ajax.reload();
                    resetFrm("frmIngreso", "btn");
                } else {

                }

            }

        });
    }

    function clearCampo(idForm, btn, campo) {
        var campo = $('#' + idForm + ' input[name="' + campo + '"]');
        $(campo).siblings('div.ui.red.pointing.label').html('');
        $(campo).siblings('div.ui.red.pointing.label').css('display', 'none');
        $(btn).removeClass('disabled');
    }

    function compNombre(idForm, btn) {
        var nombre = $('#' + idForm + ' input[name="txtUsuarioV"]');

        if (nombre.val().trim() != "") {
            fetch("controladorUsuario?operacion=compNombre&user=" + nombre.val().trim())
                .then(response => {
                    return response.json();
                })
                .then(dat => {
                    if (dat == 1) {
                        $(nombre).siblings('div.ui.red.pointing.label').html('');
                        $(nombre).siblings('div.ui.red.pointing.label').css('display', 'none');
                    } else {
                        $(nombre).siblings('div.ui.red.pointing.label').html(
                            'Este nombre de usuario ya está ocupado');
                        $(nombre).siblings('div.ui.red.pointing.label').css('display',
                            'inline-block');
                        $(btn).addClass('disabled');
                    }
                })
                .catch(err => {
                    console.log(err);
                });
        }
    }

    //AJAX PARA MODIFICAR VENDEDOR
    function modificarVendedor(datos) {

        $.ajax({
            type: 'post',
            async: false,
            dataType: 'json',
            data: {
                datos: datos
            },
            url: 'ControladorVendedor?operacion=modificarVendedor',
            success: function (result) {
                if (result == 1) {
                    status = true;
                    swal({
                        title: 'Estado de la Modificación',
                        text: 'El vendedor fue modificado correctamente',
                        type: 'success',
                        timer: 1800
                    })
                    $('#modalModificar').modal('hide');
                    tablaVendedores.ajax.reload();
                } else {
                    status = false;
                }
            }
        });
    }

    function confirmarContra(idForm, campo1, campo2, btn) {
        var campo1 = $('#' + idForm + ' input[name="' + campo1 + '"]');
        var campo2 = $('#' + idForm + ' input[name="' + campo2 + '"]');

        if ((campo1.val().trim() != "") && (campo2.val().trim() != "")) {
            if (campo1.val().trim() != campo2.val().trim()) {
                $(campo2).siblings('div.ui.red.pointing.label').html(
                    'Las contraseñas no concuerdan');
                $(campo2).siblings('div.ui.red.pointing.label').css('display',
                    'inline-block');
                $(btn).addClass('disabled');

                return false;
            } else {
                $(campo2).siblings('div.ui.red.pointing.label').html('');
                $(campo2).siblings('div.ui.red.pointing.label').css('display', 'none');
                $(btn).removeClass('disabled');

                return true;
            }
        }
    }

    /*Eliminar Vendedor*/
    function eliminarVendedor(boton) {
        var id = boton.id;

        swal({
            title: 'Eliminar Vendedor',
            text: "¿Desea eliminar este vendedor",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, Eliminar'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: 'post',
                    dataType: 'text',
                    data: {
                        dato: id
                    },
                    url: 'ControladorVendedor?operacion=eliminarVendedor',
                    success: function (result) {
                        swal({
                            title: 'Eliminación Exitosa',
                            text: 'El vendedor fue eliminado',
                            type: 'success',
                            timer: 1800
                        })

                        tablaVendedores.ajax.reload();
                    }
                });
            }
        })
    }
</script>

<script>
    $(function () {
        $('#btnCancelarReg').click(function () {
            resetFrm("frmIngreso", "btn");
        });
    });
</script>

<script>
    $('#frmIngreso input[name="txtUsuarioV"]').focusout(function () {
        compNombre("frmIngreso", "#btnRegistrarV");
    });
    $('#frmIngreso input[name="txtUsuarioV"]').focus(function () {
        clearCampo("frmIngreso", "#btnRegistrarV", this.name);
    });
</script>

<script>
    $(function () {
        $("input[name=txtConfContraV]").focusout(function () {
            confirmarContra("frmIngreso", "txtContraV", "txtConfContraV", "btnRegistrarV")
        });
    });
</script>