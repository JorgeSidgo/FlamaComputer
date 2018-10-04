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
            <button class="ui right floated positive labeled icon button"  id="btnModalRegistro"><i class="plus icon"></i>Registrar</button>
        </div>
        <!--Este es el modal de ingreso vendedor-->
        <div class="ui modal" >
            <i class="close icon"></i>
            <div class="header">
              Ingresar Vendedor
            </div>
            <div class="content" id="datosVendedor">
                <form method="get" class="ui form">
                    <div class="field">
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
                                <input type="text" name="txtDuiV" placeholder="Dui">
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
                                <input type="text" name="txtTelMovilV" placeholder="0000-0000">
                            </div>
                            <div class="field">
                                <label>Telefono Oficina</label>
                                <input type="text" name="txtTelOfiV" placeholder="0000-0000">
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui error message"></div>
                    </div>
            </div>
            <div class="actions">
                  <div class="ui black deny button">Cancelar</div>
                  <button class="ui submit button green" id="btnRegistrarV">Registrar</button>
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
<script src="tablas/tablaVendedores.js"></script>


<script>
$(document).ready(function(){
    $('#btnModalRegistro').click(function(){
        $('.ui.modal').modal('show');
    });

    $(function(){
        $('.ui.form').form({
            txtNombreV : {
                identifier : 'txtNombreV',
                rules: [
                    {
                        type : 'empty',
                        prompt : "Por favor Ingrese un nombre"
                    }
                ]
            },
            txtApellidoV : {
                identifier : 'txtApellidoV',
                rules: [
                    {
                        type : 'empty',
                        prompt : 'Por favor Ingrese un apellido'
                    }
                ]
            },
            txtDuiV : {
                identifier : 'txtDuiV',
                rules: [
                    {
                        type : 'empty',
                        prompt : 'Por favor Ingrese el numero de Dui valido'
                    },
                    {
                        type : 'regExp[/^[0-9_-]{10}$/]',
                        prompt : 'Por favor Ingrese el formato de Dui valido'
                    },
                    {
                        type : 'maxLength[10]',
                        prompt : 'Por favor Ingrese la longitud de Dui valida'
                    }
                ]
            },
            txtDireccionV : {
                identifier : 'txtDireccionV',
                rules: [
                    {
                        type : 'empty',
                        prompt : 'Por favor Ingrese su direccion de domicilio'
                    }
                ]
            },
            txtTelMovilV : {
                identifier : 'txtTelMovilV',
                rules: [
                    {
                        type : 'empty',
                        prompt : 'Por favor Ingrese su telefono movil'
                    },
                    {
                        type : 'regExp[/^[0-9_-]{9}$/]',
                        prompt : 'Por favor Ingrese un numero telefonico valido'
                    },
                    {
                        type : 'maxLength[9]',
                        prompt : 'Por favor Ingrese todos los digitos'
                    }
                ]
            },
            txtTelOfiV : {
                identifier : 'txtTelOfiV',
                rules: [
                    {
                        type : 'empty',
                        prompt : 'Por favor Ingrese su telefono movil'
                    },
                    {
                        type : 'regExp[/^[0-9_-]{9}$/]',
                        prompt : 'Por favor Ingrese un numero telefonico valido'
                    },
                    {
                        type : 'maxLength[9]',
                        prompt : 'Por favor Ingrese todos los digitos'
                    }
                ]
            }
        }, {
            onSuccess : function(e){
                e.preventDefault();
                var datosVendedor = JSON.stringify($('#datosVendedor :input').serializeArray());
                 //console.log(datosVendedor);
                ingresarVendedor(datosVendedor);
                tablaVendedores.ajax.reload();
            } 
        });
    });

});
    // AJAX PARA INGRESO DE VENDEDOR
    function ingresarVendedor(datos)
    {
        $.ajax({
            type: 'post',
            async: false,
            dataType: 'json',
            data: {datos:datos},
            url: 'ControladorVendedor?operacion=insertarVendedor',
            success: function(result){
                if (result==false) {
                    status=true;
                }else{
                    status=result;
                }
                console.log(status);
            }
        
        });
    }    
</script>