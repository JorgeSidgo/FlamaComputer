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
                                <input type="text" name="txtUsuarioV" placeholder="Usuario">
                                <div class="ui red pointing label" style="display: none;">
                                </div>
                            </div>
                            <div class="field">
                                <label>Contraseña:</label>
                                <input type="password" name="txtContraV" placeholder="Contraseña">
                                <div class="ui red pointing label" style="display: none;">
                                </div>
                            </div>
                            <div class="field">
                                <label>Confirmar contraseña:</label>
                                <input type="password" name="txtConfContraV" placeholder="Confirmar contraseña">
                                <div class="ui red pointing label" style="display: none;">
                                </div>
                            </div>
                        </div>
                        <div class="two fields">
                            <div class="field">
                                <label>Nombre</label>
                                <input type="text" name="txtNombreV" placeholder="Nombre">
                            </div>
                            <div class="field">
                                <label>Apellido</label>
                                <input type="text" name="txtApellidoV" placeholder="Apellido">
                            </div>
                            <div class="field">
                                <label>Numero de DUI</label>
                                <input type="text" class="dui" name="txtDuiV" placeholder="Dui">
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <div class="two fields">
                            <div class="field">
                                <label>Dirección</label>
                                <input type="text" name="txtDireccionV" placeholder="Dirección">
                            </div>
                            <div class="field">
                                <label>Telefono Movil</label>
                                <input type="text" name="txtTelMovilV" class="telefono" placeholder="0000-0000">
                            </div>
                            <div class="field">
                                <label>Telefono Oficina</label>
                                <input type="text" name="txtTelOfiV" class="telefono" placeholder="0000-0000">
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui error message"></div>
                    </div>
            </div>
            <div class="actions">
                <button class="ui black deny button" id="btnCancelarReg">Cancelar</button>
                <button class="ui right button green" id="btnRegistrarV">Registrar</button>
            </div>
            </form>
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
                        <input type="text" name="txtNombreV" placeholder="Nombre">
                    </div>
                    <div class="field">
                        <label>Apellido</label>
                        <input type="text" name="txtApellidoV" placeholder="Apellido">
                    </div>
                    <div class="field">
                        <label>Numero de DUI</label>
                        <input type="text" name="txtDuiV" class="dui" placeholder="Dui">
                    </div>
                </div>
            </div>
            <div class="field">
                <div class="two fields">
                    <div class="field">
                        <label>Dirección</label>
                        <input type="text" name="txtDireccionV" placeholder="Dirección">
                    </div>
                    <div class="field">
                        <label>Telefono Movil</label>
                        <input type="text" name="txtTelMovilV" class="telefono" placeholder="0000-0000">
                    </div>
                    <div class="field">
                        <label>Telefono Oficina</label>
                        <input type="text" name="txtTelOfiV" class="telefono" placeholder="0000-0000">
                    </div>
                </div>
            </div>
            <div class="field">
                <div class="ui error message"></div>
            </div>
    </div>
    <div class="actions">
        <div class="ui black deny button">Cancelar</div>
        <button class="ui submit button green" id="btnEditarV">Registrar</button>
    </div>
    </form>
</div>
<!--Aqui termina el modal-->
<script src="tablas/tablaVendedores.js"></script>


<script>
    $(document).ready(function () {
        $('#btnModalRegistro').click(function () {
            $('#modalIngreso').modal('setting', 'closable', false).modal('show');
        });

        $(document).on("click", ".btnEditar", function () {
            $('#modalModificar').modal('show');
            var id = this.id;
            $("#idV").val(id);
        });

        $(document).on("click", ".btnEliminar", function () {
            eliminarVendedor(this);
        });

        $(function () {
            $('#frmIngreso').form({
                txtNombreV: {
                    identifier: 'txtNombreV',
                    rules: [{
                        type: 'empty',
                        prompt: "Por favor Ingrese un nombre"
                    }]
                },
                txtApellidoV: {
                    identifier: 'txtApellidoV',
                    rules: [{
                        type: 'empty',
                        prompt: 'Por favor Ingrese un apellido'
                    }]
                },
                txtDuiV: {
                    identifier: 'txtDuiV',
                    rules: [{
                            type: 'empty',
                            prompt: 'Por favor Ingrese el numero de Dui valido'
                        },
                        {
                            type: 'regExp[/^[0-9_-]{10}$/]',
                            prompt: 'Por favor Ingrese el formato de Dui valido'
                        },
                        {
                            type: 'maxLength[10]',
                            prompt: 'Por favor Ingrese la longitud de Dui valida'
                        }
                    ]
                },
                txtDireccionV: {
                    identifier: 'txtDireccionV',
                    rules: [{
                        type: 'empty',
                        prompt: 'Por favor Ingrese su direccion de domicilio'
                    }]
                },
                txtTelMovilV: {
                    identifier: 'txtTelMovilV',
                    rules: [{
                            type: 'empty',
                            prompt: 'Por favor Ingrese su telefono movil'
                        },
                        {
                            type: 'regExp[/^[0-9_-]{9}$/]',
                            prompt: 'Por favor Ingrese un numero telefonico valido'
                        },
                        {
                            type: 'maxLength[9]',
                            prompt: 'Por favor Ingrese todos los digitos'
                        }
                    ]
                },
                txtUsuraioV: {
                    identifier: 'txtUsuarioV',
                    rules: [{
                            type: 'empty',
                            prompt: 'Por favor Ingrese su Nombre de Usuario'
                        }
                    ]
                },
                txtContraV: {
                    identifier: 'txtContraV',
                    rules: [{
                            type: 'empty',
                            prompt: 'Por favor Ingrese su Contraseña'
                        }
                    ]
                },
                txtTelOfiV: {
                    identifier: 'txtTelOfiV',
                    rules: [{
                            type: 'empty',
                            prompt: 'Por favor Ingrese su telefono movil'
                        },
                        {
                            type: 'regExp[/^[0-9_-]{9}$/]',
                            prompt: 'Por favor Ingrese un numero telefonico valido'
                        },
                        {
                            type: 'maxLength[9]',
                            prompt: 'Por favor Ingrese todos los digitos'
                        }
                    ]
                }
            }, {
                onSuccess: function (e) {
                    e.preventDefault();
                    var datosVendedor = JSON.stringify($('#datosVendedor :input').serializeArray());
                    console.log(datosVendedor);
                    ingresarVendedor(datosVendedor);
                }
            });
        });

        $(function () {
            $('#frmModificar').form({
                txtNombreV: {
                    identifier: 'txtNombreV',
                    rules: [{
                        type: 'empty',
                        prompt: "Por favor Ingrese un nombre"
                    }]
                },
                txtApellidoV: {
                    identifier: 'txtApellidoV',
                    rules: [{
                        type: 'empty',
                        prompt: 'Por favor Ingrese un apellido'
                    }]
                },
                txtDuiV: {
                    identifier: 'txtDuiV',
                    rules: [{
                            type: 'empty',
                            prompt: 'Por favor Ingrese el numero de Dui valido'
                        },
                        {
                            type: 'regExp[/^[0-9_-]{10}$/]',
                            prompt: 'Por favor Ingrese el formato de Dui valido'
                        },
                        {
                            type: 'maxLength[10]',
                            prompt: 'Por favor Ingrese la longitud de Dui valida'
                        }
                    ]
                },
                txtDireccionV: {
                    identifier: 'txtDireccionV',
                    rules: [{
                        type: 'empty',
                        prompt: 'Por favor Ingrese su direccion de domicilio'
                    }]
                },
                txtTelMovilV: {
                    identifier: 'txtTelMovilV',
                    rules: [{
                            type: 'empty',
                            prompt: 'Por favor Ingrese su telefono movil'
                        },
                        {
                            type: 'regExp[/^[0-9_-]{9}$/]',
                            prompt: 'Por favor Ingrese un numero telefonico valido'
                        },
                        {
                            type: 'maxLength[9]',
                            prompt: 'Por favor Ingrese todos los digitos'
                        }
                    ]
                },
                txtTelOfiV: {
                    identifier: 'txtTelOfiV',
                    rules: [{
                            type: 'empty',
                            prompt: 'Por favor Ingrese su telefono movil'
                        },
                        {
                            type: 'regExp[/^[0-9_-]{9}$/]',
                            prompt: 'Por favor Ingrese un numero telefonico valido'
                        },
                        {
                            type: 'maxLength[9]',
                            prompt: 'Por favor Ingrese todos los digitos'
                        }
                    ]
                }
            }, {
                onSuccess: function (e) {
                    e.preventDefault();
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
                            var datosVendedor = JSON.stringify($(
                                '#datosModificarV :input').serializeArray());
                            //console.log(datosVendedor);
                            modificarVendedor(datosVendedor);
                        }
                    })
                }
            });
        });

    });
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
                var campo = $('#' + idForm + ' input[name="'+ campo +'"]');
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