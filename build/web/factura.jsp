<%-- 
    Document   : factura
    Created on : 09-18-2018, 10:53:24 PM
    Author     : jsidg
--%>

<%@page import="com.dao.DaoFactura"%>
<%@page import="java.util.*"%>
<%@page import="com.modelo.Producto"%>
<%@page import="com.dao.DaoProducto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    DaoProducto daoP= new DaoProducto();
    DaoFactura daoF = new DaoFactura();
    List<Producto> productos = daoP.mostrarProductos();
    
%>

<%@include file="components/header.jsp" %>
<style>
    .derecha{
        /* ASDFIUOSDGASDF */
    }
    .titulo2 {
        font-size: 24px;
        font-weight: bolder;
        border-bottom: 1px solid rgba(0,0,0,0.1);
        padding-bottom: 7px; 
        width: 50%;
        font-family: 'google-bold';
    }
    .titulo2 > span {
        font-size: 24px;
        font-weight: lighter;
    }

</style>

<div id="app">

    <modal id='modalEliminar'titulo="Facturar" :campos="campos" :para='modal' @enviado='enviado' @cambio='cambio' @cancelar='cancelar'></modal>
    <modal id='cliente'titulo="Cliente" :campos="campoCliente" :para='modal' @enviado='datosCliente' :deshabilitarenviar='isdatocliente' @nombre="habilitar"></modal>
    <modal id='factura'titulo="Facturar" :campos="campoFacturar" :para='modal' :deshabilitarenviar='isEnviarFactura' @efectivo='efectivo' @enviado='registrarFactura'></modal>
    
    <div class="ui grid">
        <div class="row">
            <div class="titulo2">
                Factura:
                <span>  N° <%= daoF.numeroFactura() %> </span>
            </div>
            <div class="titulo2" style='text-align:right'>
                Cliente: <span>{{cliente.nombre}} {{cliente.apellido}}</span>
                <button :class='["ui icon button", {positive:isCliente}, {teal:!isCliente} ] ' @click='nueveoCliente'>
                    <i class='plus icon' v-if="isCliente"></i> 
                    <i class='pencil alternate icon' v-else ></i> 
                </button>
            </div>
        </div>
        <div class="row title-bar">
            <div class="sixteen wide column">
                <button class="ui positive labeled icon button" @click="addModal" id="btnModalRegistro">
                    <i class="plus icon"></i>
                    Nuevo
                </button>
                <input :class="['ui', 'right', 'floated', 'primary', 'button',{disabled:isfacturar},{disabled:isCliente}]" @click="facturar" id="btnFacturar" type='button' value='Facturar'>
                <div class="ui negative message" v-if="isfacturar||isCliente ">
                      <ul style="list-style-type: disc; margin-left:1em ">
                        <li v-if="isfacturar">Debe registrar al menos un producto en la factura</li>
                        <li v-if="isCliente">Debe registrar un cliente</li>
                      </ul>  
                </div>
            </div>
        </div>
        <div class="row title-bar">
            <div class="sixteen wide column">
                <div class="ui divider"></div>
            </div>
        </div>
        <div class="row">
            <div class="sixteen wide column">
                <table id="dtFactura" class="ui selectable very compact celled table" style="width:100%; margin:auto;">
                    <thead>
                        <tr>
                            <th>Codigo</th>
                            <th>Producto</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th>SubTotal</th>
                            <th>Accion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for='(fila, index) in tabla' :key='index'>
                            <td>{{ fila.id }}</td>
                            <td>{{ fila.producto }}</td>
                            <td class='derecha'>{{ fila.precio | moneda }}</td>
                            <td class='derecha'>{{ fila.cantidad }}</td>
                            <td class='derecha'>{{ subtotal(fila.precio,fila.cantidad) | moneda }}</td>
                            <td>
                                <button class='ui icon button blue' @click='editar(fila.id,fila.producto,fila.precio,fila.cantidad,index)'>
                                    <i class='pencil alternate icon'></i> 
                                </button>
                                <button class='ui icon button negative' @click='eliminarProducto(index)'>
                                    <i class="eraser icon"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan='4'>Total</td>
                            <td class='derecha' colspan='2'><strong>{{ total | moneda }} </strong></td>
                        </tr>
                        <tr>
                            <td colspan='4'>Total + IVA</td>
                            <td class='derecha' colspan='2'><strong>{{ total+(total*0.13) | moneda }} </strong></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</div>

<script src="./res/js/app.js"></script>

<script>
    
var datosP=[

<%
    for (Producto elemento : productos)
{%>
    {codigo: <%= elemento.getCodigoProducto()  %>  ,nombre: '<%= elemento.getNombreProducto()  %>' ,precio: <%= elemento.getPrecioVenta() %>, stock:  <%= elemento.getStockActual()  %>},
<% } %> 
    
    ];
    
let app= new Vue({
    el:'#app',
    data:{
        modal:"registrar",
        cliente:{
            codigo: <%= daoF.numeroCliente() %>,
            nombre:"[Registre un ",
            apellido: "cliente]",
            direccion: "",
        },
        isdatocliente:true,
        isCliente:true,
        filaSelecionada:0,
        // isfacturar:true,
        isEnviarFactura:true,
        campos : [
            {label:"Producto", name:'producto', type:'select', options:[
//                {val: '1', text: 'churrito'},
//                {val: '12', text: 'elotito'},
//                {val: '13', text: 'quisitrix'}
            ]},
            {label:"Precio", name:'precio', type:'number', step:'any', val:0, disabled:'disabled'},
            {label:"Cantidad", name:'cantidad', type:'number', val:'0', min:0, max:100},
        ],
        campoCliente:[
            {label:"Nombre", name:'nombre', type:'text'},
            {label:"apellido", name:'apellido', type:'text'},
            {label:"Direccion", name:'direccion', type:'text'}
        ],
        campoFacturar:[
            {label:"Total", name:'total', type:'text',disabled:'disabled', val:''},
            {label:"Efectivo", name:'efectivo', type:'number', step:"any", min:0},
            {label:"Cambio", name:'vuelto', type:'text', disabled:'disabled', val:'$ 0.00' },
        ],
        tabla:[
            // {id:1, producto:'churrito', precio:0.10, cantidad:1},
            // {id:12, producto:'elotito', precio:0.10, cantidad:3},
            // {id:13, producto:'quisitrix', precio:0.25, cantidad:2}
        ]
    },
    mounted(){
        if(datosP.length==0){
            swal(
                'No hay productos',
                'Debe registrar productos para poder realizar una venta',
                'error'
            ).then(()=>{
                window.location='productos.jsp'
            });
        }
        for (let i = 0; i < datosP.length; i++) {
                this. campos[0].options.push({val: datosP[i].codigo , text: datosP[i].nombre}); 
            }
    },
    computed:{
        total(){
            let x=0;
            for (let i = 0; i < this.tabla.length; i++) {
                 x+=(this.tabla[i].precio*this.tabla[i].cantidad);
            }   
            return x;
        },
        totalIVA(){
            let res=this.total+(this.total*0.13);
            return res.toFixed(2);
        },
        isfacturar(){
            let val=true;
            if(this.tabla.length>0){
                val=false;
            }else{
                val=true;
            }
            return val;
        }
    },
    filters:{
        moneda(val){
            let res=val.toFixed(2);
            return '$ '+ res.toString();
        }
    },
    methods: {
//----------------------------------------------------------------
        //METODOS MODAL PARA AGREGAR PRODUCTO A DETALLE
        
        addModal() {    //ES PARA CONFIGURAR Y ABRIR EL MODAL 
            this.campos[1].val=datosP[0].precio.toFixed(2);
            this.campos[2].val=0;
            this.campos[2].max=datosP[0].stock;
            $('#modalEliminar').modal('setting', 'autofocus', false).modal('setting', 'closable', false).modal('show');
        },
        cambio(val){    //SE ACTIVA AL CAMBIAR EL VALOR DEL SELECT PRODUCTO
            
            var ind;
            datosP.forEach((elemento,index) => {
                if(val[0].value==elemento.codigo){
                    ind= index;
                }
            });
            
            this.campos[1].val=datosP[ind].precio.toFixed(2);
            this.campos[2].val=0;
            this.campos[2].max=datosP[ind].stock;
        },
        cancelar(){     //SE ACTIVA AL CANCELAR EL MODAL
            this.modal='registrar';
        },
        enviado(val){   //RECIBE Y PROCESA LOS DATOS DEL MODAL
        // console.log(val);
            if(val[0].para=='editar'){
                this.tabla.splice(this.filaSelecionada,1,{id:val[0].value,producto: val[0].texto, precio: parseFloat(val[1].value), cantidad: parseInt(val[2].value)});
            }else{
                this.tabla.push({id:val[0].value,producto: val[0].texto, precio: parseFloat(val[1].value), cantidad: parseInt(val[2].value)})
            }
            // this.isfacturar=false;
            this.modal='registrar';
        },
        editar(idProducto,nombre, precio, cantidad,indice){
            //ESTABLECE LOS VALORES DEL REGISTRO A CAMBIAR EN EL MODAL
            this.modal='editar';
            this.filaSelecionada=indice;
            this.campos[1].val=precio.toFixed(2);
            this.campos[2].val=cantidad;

            $('.item.active').removeClass('selected');
            $('.item.active').removeClass('active');
            $('[data-value='+idProducto+']').addClass('selected');
            $('[data-value='+idProducto+']').addClass('active');

            $('.text').html(nombre);
            
            $('#modalEliminar').modal('setting', 'closable', false).modal('show');

        },

//----------------------------------------------------------------
        //METODOS MODAL PAGAR FACTURA
        
        facturar(){     //ABRE EL MODAL PARA PAGAR FACTURA
            this.campoFacturar[0].val='$ '+this.totalIVA;
            this.campoFacturar[1].val=null;
            this.campoFacturar[2].val='$ 0.00';
            $('#factura').modal('setting', 'autofocus', false).modal('setting', 'closable', false).modal('show');
            $('#efectivo').focus();
        },
        registrarFactura(val){      //ENVIA TODOS LOS DATOS AL CONTROLADOR PARA SU REGISTRO EN LA DB
            
            let datos={
                nfactura: <%= daoF.numeroFactura() %>,
                vendedor:1,
                cliente: this.cliente,
                total:this.total,
                totalIVA: this.totalIVA,
                efectivo: val[1].value,
                cambio: val[2].value,
                detalle:this.tabla,
            };

            let parametros={
                method: 'post',
                headers: {
                    "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: 'datos='+JSON.stringify(datos)
            }

            fetch('ControladorFactura?op=1',parametros)
            .then(response=>{ return response.json(); })
            .then(val=>{
                if(val==0){
                    swal({
                        title:'No se pudo registrar la factura',
                        text:'La venta NO se ha realizado',
                        type:'error',
                    })
                }else{
                    window.open("ControladorFactura?op=2&nfactura=<%= daoF.numeroFactura() %>", "Factura", "width=500, height=675");
                    swal({
                            title:'Venta realizada!',
                            text:'La venta se ha realizado exitosamente',
                            type:'success',
                        }).then(()=>{
                            window.location='factura.jsp';
                        })
                }
            })
        },
        efectivo(val){  //SE ACTIVA AL CAMBIAR LA CANTIDAD DE EFECTIVO PARA PAGAR
            this.campoFacturar[2].val='$ '+(val-this.totalIVA).toFixed(2);
            if(val>=this.totalIVA){
                this.isEnviarFactura=false;
            }else{
                this.isEnviarFactura=true;
            }
        },

//----------------------------------------------------------------
        //METODOS MODAL NUEVO CLIENTE
        nueveoCliente(){
            $('#cliente').modal('setting', 'autofocus', false).modal('setting', 'closable', false).modal('show');
            
        },
        datosCliente(val){
            this.isCliente=false;
            this.cliente.nombre=val[0].value;
            this.cliente.apellido=val[1].value;
            this.cliente.direccion=val[2].value;
        },
        habilitar(val){
            if (val.length>2) {
                this.isdatocliente=false;
            }else{
                this.isdatocliente=true;
            }
        },
        datosCliente(val){
            this.isCliente=false;
            this.cliente.nombre=val[0].value;
            this.cliente.apellido=val[1].value;
            this.cliente.direccion=val[2].value;
        },
        habilitar(val){
            if (val.length>2) {
                this.isdatocliente=false;
            }else{
                this.isdatocliente=true;
            }
        },

        //METODOS LOCALES
        subtotal(precio,cantidad){
            return precio*cantidad;
        },
        eliminarProducto(indice){
            swal({
                title: '¿Esta seguro que desea eliminar el registro?',
                text: "No podrá revertir esta acción",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sí, eliminar!'
                }).then((result) => {
                if (result.value) {
                    this.tabla.splice(indice,1);
                    // this.isfacturar=true;

                    swal({
                        title:'Eliminado!',
                        text:'El registor ha sido eliminado',
                        type:'success',
                        timer:1500
                    })
                }
            })
    
        }
    }
    });
    
</script>

