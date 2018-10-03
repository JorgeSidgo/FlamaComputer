
Vue.component('modal-registrar', {

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

    mounted() {
        $('.ui.checkbox').checkbox();
        $('.ui.radio.checkbox').checkbox();
    },
    updated() {
        for (let index = 0; index < this.campos.length; index++) {
            if (this.campos[index].selected == undefined) {} else {

            }
        }
    },

    methods: {
        registrar() {
            var gatos = {};

            $('#' + this.id_form).addClass('loading');

            $('#' + this.id_form).find(":input").each(function() {
                gatos[this.name] = $(this).val();
            });
            
            gatos = JSON.stringify(gatos);

            console.log(gatos);
            var param = {
                method: 'POST',
                headers: {
                    "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: "datos=" + gatos,
            };


            fetch(this.url, param)
                .then(response => {
                    return response.text();
                })
                .then(val => {
                    if(val == 1)
                    {
                        swal({
                            title:'Registrado',
                            text:'El elemento fue registrado exitosamente',
                            type:'success',
                            showConfirmButton: false,
                            timer:1500
                        }
                        );
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
                    <h4 v-if="sub_titulo">{{sub_titulo}}</h4>
                    <form action="" class="ui equal width form" :id="id_form">
                        <div v-for="campo in campos" class="field">
                            <label>{{campo.label}} </label>
                            <select class="ui dropdown" v-if="campo.type == 'select'" :name="campo.name" :id="campo.name">
                                <option v-for="(op,i) in campo.options" :value="op.val" :key='i' :id="op.val+'_'+i">
                                    {{op.text}}
                                </option>  
                            </select>
                            <div class="ui radio checkbox" v-else-if="campo.type == 'radio'" v-for="(op,index) in campo.options" :key='index'>
                                <input type="radio" name="campo.name" tabindex="0" class="hidden" v-model='campo.value' :value='op.val' :checked='index==0'>
                                <label>{{op.text}}</label>
                            </div>

                            <div class="ui checkbox" v-else-if="campo.type == 'checkbox'" v-for="(op,index) in campo.options" :key='index'>
                                <input type="checkbox" tabindex="0" class="hidden" name="campo.name" v-model='campo.value' :value='op.val'>
                                <label>{{op.text}}</label>
                            </div>

                            <input v-else-if="campo.type == 'number'" class="reqRegistrar" :type="campo.type" :name="campo.name" :min="campo.min" :max="campo.max" :id="campo.name" v-model.number="campo.val" :step='campo.step' :disabled='campo.disabled'>

                            <input v-else class="reqRegistrar" :type="campo.type" :name="campo.name" :id="campo.name" v-model="campo.val" :disabled='campo.disabled'>
                            <div class="ui red pointing label" style="display: none;">
                            </div>
                        </div>
                    </form>        
                </div>
                <div class="actions">
                    <button class="ui black deny button">
                        Cancelar
                    </button>
                    <button class="ui right green button" @click="registrar" >
                        Registrar
                    </button>
                </div>
            </div>`
});
