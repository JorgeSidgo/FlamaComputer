<%-- 
    Document   : productos
    Created on : 09-18-2018, 08:00:52 PM
    Author     : jsidg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>

<div id="app">
   <modal-registrar id_form="frmRegistrar" id="modalRegistrar" url="controladorProductos?operacion=registrar" titulo="Registrar Producto"
        :campos="campos_registro" tamanio='small'></modal-registrar>
    <modal-editar id_form="frmEditar" id="modalEditar" url="controladorProductos?operacion=editar" titulo="Editar Productos"
        :campos="campos_editar" tamanio='small'></modal-editar>
    <modal-eliminar id_form="frmEliminar" id="modalEliminar" url="controladorProductos?operacion=eliminar" titulo="Eliminar Producto"
        sub_titulo="¿Está seguro de querer eliminar este producto?" :campos="campos_eliminar" tamanio='tiny'></modal-eliminar>

    <div class="ui grid">
        <div class="row">
            <div class="titulo">
                Productos
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
                    <table id="dtProductos" class="ui selectable very compact celled table" style="width:100%; margin:auto;">
                        <thead>
                            <tr>
                                <th>idProducto</th>
                                <th>Producto</th>
                                <th>Precio</th>
                                <th>Stock Mínimo</th>
                                <th>Stock Actual</th>
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

<script src="tablas/tablaProductos.js"></script>
<script src="res/js/modalRegistrar.js"></script>
<script src="res/js/modalEditar.js"></script>
<script src="res/js/modalEliminar.js"></script>

<script>
    var app = new Vue({
        el: "#app",
        data: {
            campos_registro: [{
                    label: 'Producto',
                    name: 'nombreProducto',
                    type: 'text'
                },
                {
                    label: 'Precio de Venta',
                    name: 'precioVenta',
                    type: 'number',
                    step: 'any'
                },
                {
                    label: 'Stock Mínimo',
                    name: 'stockMinimo',
                    type: 'number'
                },
                {
                    label: 'Stock Actual',
                    name: 'stockActual',
                    type: 'number'
                },
                /*
                 * {
                 *      label: 'Codigo de Barras (Valor definitivo)'
                 *      name: 'codigoBarra',
                 *      type: 'text'
                 * }
                 */
            ],
            campos_editar: [{
                    label: 'Producto',
                    name: 'nombreProducto',
                    type: 'text'
                },
                {
                    label: 'Precio de Venta',
                    name: 'precioVenta',
                    type: 'number',
                    step: 'any'
                },
                {
                    label: 'Stock Mínimo',
                    name: 'stockMinimo',
                    type: 'number'
                },
                {
                    label: 'Stock Actual',
                    name: 'stockActual',
                    type: 'number'
                },
                {
                    label: '',
                    name: 'codigoProducto',
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
                tablaProductos.ajax.reload();
            },
            modalRegistrar() {
                $('#modalRegistrar').modal('setting', 'closable', false).modal('show');
            },
            modalEliminar() {
                $('#modalEliminar').modal('setting', 'closable', false).modal('show');
            },
            cargarDatos() {
                var id = $('#codigoProducto').val();
                fetch("controladorProductos?operacion=getProducto&id=" + id)
                .then(response => {
                    return response.json();
                })
                .then(dat => {
                    $('input[name="nombreProducto"]').val(dat.nombreProducto);
                    $('input[name="precioVenta"]').val(dat.precioVenta);
                    $('input[name="stockMinimo"]').val(dat.stockMinimo);
                    $('input[name="stockActual"]').val(dat.stockActual);
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
        $('#codigoProducto').val($(this).attr("id"));
        app.cargarDatos();
    });
</script>

