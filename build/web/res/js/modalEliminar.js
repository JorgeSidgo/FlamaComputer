Vue.component('modal-eliminar', {

    props: {

        id: {
            type: String,
            required: true
        },
        id_form: {
            type: String
        },
        titulo: {
            type: String,
            required: true
        },
        para: {
            type: String,
            required: false
        },
        sub_titulo: {
            type: String,
            required: false
        },
        tamanio: {
            type: String,
            required: false
        },
        campos: {
            type: Array,
            required: false
        },
        url: {
            type: String,
            required: false
        }
    },

    methods: {
        eliminar() {

            var id = $('#idEliminar').val();

            var param = {
                method: 'POST',
                headers: {
                    "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: "id=" + id,
            };

            fetch(this.url, param)
                .then(response => {
                    return response.text();
                })
                .then(val => {
                    if (val == 1) {
                        swal({
                            title: 'Eliminado',
                            text: 'El elemento fue eliminado exitosamente',
                            type: 'success',
                            showConfirmButton: false,
                            timer: 1500
                        })
                        $('#' + this.id_form).removeClass('loading');
                        $('#' + this.id).modal('hide');
                        this.$parent.refrescarTabla();
                    }
                }).catch(res => {
                    console.log(res);
                });
        }
    },


    template: `<div :class="['ui','modal',tamanio]" :id="id">

                <div class="header">
                    {{titulo}}
                </div>
                <div class="content">
                    <h4>{{sub_titulo}}</h4>
                    <form action="" class="ui equal width form" :id="id_form">
                        <div class="fields">
                            <div v-for="campo in campos" class="field">
                                <input class="reqRegistrar" :type="campo.type" :name="campo.name" :id="campo.name" v-model="campo.val" :disabled='campo.disabled'>
                                <div class="ui red pointing label" style="display: none;">
                                </div>
                            </div>
                        </div>
                    </form>        
                </div>
                <div class="actions">
                    <button class="ui black deny button">
                        Cancelar
                    </button>
                    <button class="ui right red button" id="btnEliminar" @click="eliminar" >
                        Eliminar
                    </button>
                </div>
            </div>`
});