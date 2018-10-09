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
                    label: 'Confirmar contraseña:',
                    name: 'confPass',
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
                        }
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
                        }
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
            }],
            contador: 0,
            nomActual: 'simona'
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

                if (contra.val().trim() != "") {

                    fetch("controladorUsuario?operacion=compContra&user=<%= nombreUsuario%>&pass=" + contra.val()
                            .trim())
                        .then(response => {
                            return response.json();
                        })
                        .then(dat => {
                            if (dat == 1) {
                                $(contra).siblings('div.ui.red.pointing.label').html('');
                                $(contra).siblings('div.ui.red.pointing.label').css('display', 'none');
                                this.comp--;
                                alert(this.comp);
                            } else {
                                $(contra).siblings('div.ui.red.pointing.label').html(
                                    'La constraseña no concuerda');
                                $(contra).siblings('div.ui.red.pointing.label').css('display',
                                    'inline-block');
                                this.comp++;
                                alert(this.comp);
                            }
                        })
                        .catch(err => {
                            console.log(err);
                        });
                }
            },
            clearCampo(idForm, btn) {
                var nombre = $('#' + idForm + ' input[name="nombreUsuario"]');
                $(nombre).siblings('div.ui.red.pointing.label').html('');
                $(nombre).siblings('div.ui.red.pointing.label').css('display', 'none');
                $(btn).removeClass('disabled');
            },
            controlBoton(idForm, btn) {

            },
            compNombre(idForm, btn) {
                var nombre = $('#' + idForm + ' input[name="nombreUsuario"]');
                if (nombre.val().trim() != "") {
                    fetch("controladorUsuario?operacion=compNombre&user=" + nombre.val().trim())
                        .then(response => {
                            return response.json();
                        })
                        .then(dat => {
                            if (dat == 1) {
                                $(nombre).siblings('div.ui.red.pointing.label').html('');
                                $(nombre).siblings('div.ui.red.pointing.label').css('display', 'none');
                                $(btn).removeClass('disabled');
                                this.compPerm(nombre.val().trim(), 'ext');
                            } else {
                                $(nombre).siblings('div.ui.red.pointing.label').html(
                                    'Este nombre de usuario ya está ocupado');
                                $(nombre).siblings('div.ui.red.pointing.label').css('display',
                                    'inline-block');
                                $(btn).addClass('disabled');
                                this.compPerm(nombre.val().trim(), 'add');
                            }
                        })
                        .catch(err => {
                            console.log(err);
                        });
                }

                
            },
            cargarDatos() {
                var id = $('#codigoUsuario').val();
                fetch("controladorUsuario?operacion=getUsuario&id=" + id)
                    .then(response => {
                        return response.json();
                    })
                    .then(dat => {
                        $('#frmEditar input[name="nombreUsuario"]').val(dat.nombreUsuario);
                        $('#frmEditar select[name="codigoRol"]').dropdown('set selected', dat.codigoRol);
                    })
                    .catch(err => {
                        console.log(err);
                    });
            },

            confirmarContra(idForm, campo1, campo2, btn) {
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
            },
            compPerm(nom, op) {
                console.log("nom: " + nom);
                console.log("nomAct: " + this.nomActual);
                if (nom == this.nombreActual) {
                    alert("jaj al chile");
                } else {
                    alert("nelsonsimon");
                    switch (op) {
                        case 'add':
                            this.contador++;
                            break;
                        case 'ext':
                            this.contador--;
                            break;
                    }
                }
                this.nomActual = nom;
                console.log("Contador: " + this.contador);
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

    $('#frmRegistrar input[name="nombreUsuario"]').focusout(function () {
        app.compNombre("frmRegistrar", "#btnRegistrar");
    });

    $('#frmRegistrar input[name="confPass"]').focusout(function () {
        app.confirmarContra("frmRegistrar", "pass", this.name, "#btnRegistrar");
    });

    /*  $('#frmEditar input[name="nombreUsuario"]').focusout(function () {
         app.compNombre("frmEditar", "#btnEditar");
     }); */

    /* $('#frmRegistrar input[name="nombreUsuario"]').focus(function () {
        app.clearCampo("frmRegistrar", "#btnRegistrar");
    });
 */
    /* $('#frmEditar input[name="nombreUsuario"]').focus(function () {
        app.clearCampo("frmEditar", "#btnEditar");
    }); */

    $('input[name="passConf"]').focusout(function () {
        app.compContra();
    });
</script>