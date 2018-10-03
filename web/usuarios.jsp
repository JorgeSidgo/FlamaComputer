<%-- 
    Document   : usuarios
    Created on : 09-18-2018, 10:55:50 PM
    Author     : jsidg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>

<div id="app">

    <modal-registrar id_form="frmRegistrar" id="modalRegistrar" url="controladorUsuario?operacion=registrar" titulo="Registrar Usuario"
        :campos="campos_registro" tamanio='tiny'></modal-registrar>

    <modal-editar id_form="frmEditar" id="modalEditar" url="controladorUsuario?operacion=editar" titulo="Editar Usuario"
        :campos="campos_editar" tamanio='tiny'></modal-editar>

    <modal-eliminar id_form="frmEliminar" id="modalEliminar" url="controladorUsuario?operacion=eliminar" titulo="Eliminar Usuario"
        sub_titulo="¿Está seguro de querer eliminar este usuario?" :campos="campos_eliminar" tamanio='tiny'></modal-eliminar>

    <div class="ui grid">
        <div class="row">
            <div class="titulo">
                Usuarios
            </div>
        </div>
        <div class="row title-bar">
            <div class="sixteen wide column">
                <button class="ui right floated positive labeled icon button" @click="modalRegistrar" id="btnModalRegistro">
                    <i class="plus icon"></i>
                    Registrar
                </button>
            </div>
        </div>
        <div class="row title-bar">
            <div class="sixteen wide column">
                <div class="ui divider"></div>
            </div>
        </div>
        <div class="row">
            <div class="sixteen wide column">
                <table id="dtUsuarios" class="ui selectable very compact celled table" style="width:100%; margin:auto;">
                    <thead>
                        <tr>
                            <th>idUsuario</th>
                            <th>Nombre de Usuario</th>
                            <th>Permisos</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</div>

<script src="tablas/tablaUsuarios.js"></script>
<script src="res/js/modalRegistrar.js"></script>
<script src="res/js/modalEditar.js"></script>
<script src="res/js/modalEliminar.js"></script>

<script>
    var app = new Vue({
        el: "#app",
        data: {
            campos_registro: [{
                    label: 'Usuario:',
                    name: 'nombreUsuario',
                    type: 'text'
                },
                {
                    label: 'Contraseña:',
                    name: 'pass',
                    type: 'password'
                },
                {
                    label: 'Rol:',
                    name: 'codigoRol',
                    type: 'select',
                    options: [{
                            val: '1',
                            text: 'Administrador'
                        },
                        {
                            val: '2',
                            text: 'Desarrollador'
                        },
                        {
                            val: '3',
                            text: 'Vendedor'
                        },
                    ]
                },

            ],
            campos_editar: [{
                    label: 'Usuario:',
                    name: 'nombreUsuario',
                    type: 'text'
                },
                {
                    label: 'Contraseña Antigua:',
                    name: 'passConf',
                    type: 'password'
                },
                {
                    label: 'Contraseña Nueva:',
                    name: 'pass',
                    type: 'password'
                },
                {
                    label: 'Rol:',
                    name: 'codigoRol',
                    type: 'select',
                    options: [{
                            val: '1',
                            text: 'Desarrollador'
                        },
                        {
                            val: '2',
                            text: 'Administrador'
                        },
                        {
                            val: '3',
                            text: 'Vendedor'
                        },
                    ]
                },
                {
                    label: '',
                    name: 'codigoUsuario',
                    type: 'hidden'
                }

            ],
            campos_eliminar: [{
                name: 'idEliminar',
                type: 'hidden'
            }]
        },
        methods: {
            refrescarTabla() {
                tablaUsuarios.ajax.reload();
            },
            modalRegistrar() {
                $('#modalRegistrar').modal('setting', 'closable', false).modal('show');
            },
            compContra() {
                var contra = $('input[name="passConf"]');
                fetch("controladorUsuario?operacion=compContra&user=<%= nombreUsuario%>&pass=" + contra.val())
                    .then(response => {
                        return response.json();
                    })
                    .then(dat => {
                        if (dat == 1) {
                            $(contra).siblings('div.ui.red.pointing.label').html('');
                            $(contra).siblings('div.ui.red.pointing.label').css('display', 'none');
                        }else{
                            $(contra).siblings('div.ui.red.pointing.label').html(
                                'La constraseña no concuerda');
                            $(contra).siblings('div.ui.red.pointing.label').css('display', 'inline-block');
                        }
                    })
                    .catch(err => {
                        console.log(err);
                    });
            },
            cargarDatos() {
                var id = $('#codigoUsuario').val();
                fetch("controladorUsuario?operacion=getUsuario&id=" + id)
                    .then(response => {
                        return response.json();
                    })
                    .then(dat => {
                        $('input[name="nombreUsuario"]').val(dat.nombreUsuario);
                        $('select[name="codigoRol"]').dropdown('set selected', dat.codigoRol);
                    })
                    .catch(err => {
                        console.log(err);
                    });
            }
        }

    });
</script>

<script>
    $(document).on("click", ".btnEliminar", function () {
        $('#modalEliminar').modal('setting', 'closable', false).modal('show');
        $('#idEliminar').val($(this).attr("id"));
    });

    $(document).on("click", ".btnEditar", function () {
        $('#modalEditar').modal('setting', 'closable', false).modal('show');
        $('#codigoUsuario').val($(this).attr("id"));
        app.cargarDatos();
    });

    $('input[name="passConf"]').focusout(function () {
        app.compContra();
    });
</script>