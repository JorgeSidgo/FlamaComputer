var tablaVendedores;
$(function () {
    if ($('#dtVendedores').length) {
        tablaVendedores = $('#dtVendedores').DataTable({
            "ajax": {
                "url": "ControladorVendedor?operacion=tablaVendedores",
                "type": "POST"
            },
            "columns": [{
                    "data": "Codigo Vendedor"
                },
                {
                    "data": "Nombre de Usuario"
                },
                {
                    "data": "Nombre"
                },
                {
                    "data": "Apellido"
                },
                {
                    "data": "Dui"
                }, 
                {
                    "data": "Dirección"
                },
                {
                    "data": "Telefono Oficina"
                },
                {
                    "data": "Telefono Movil"
                },
                {
                    "data": "Codigo Usuario"
                },
                {
                    "data": "Acciones"
                }
            ],
            "order": [
                [0, "desc"]
            ],
            "language": {
                "sProcessing": "Procesando...",
                "sLengthMenu": "Mostrar _MENU_ registros",
                "sZeroRecords": "No se encontraron resultados",
                "sEmptyTable": "Ningún dato disponible en esta tabla",
                "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                "sInfoPostFix": "",
                "sSearch": "Buscar:",
                "sUrl": "",
                "sInfoThousands": ",",
                "sLoadingRecords": "Cargando...",
                "oPaginate": {
                    "sFirst": "Primero",
                    "sLast": "Último",
                    "sNext": "Siguiente",
                    "sPrevious": "Anterior"
                },
                "oAria": {
                    "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                }
            }
        }); // Termina configuración de dataTable


        // Ocultar columna de id de Usuario
        tablaVendedores.column(7).visible(false);

        // export {tablaUsuarios};

    }
});