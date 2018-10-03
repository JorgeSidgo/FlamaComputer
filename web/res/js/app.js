Vue.component('modal', {

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
        para:{
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
        deshabilitarenviar:{
            type:Boolean
        }
    },

    mounted() {
        $('.ui.checkbox').checkbox();
        $('.ui.radio.checkbox').checkbox();
        
        
        // $('select.dropdown').dropdown();
    },

methods:{
    envio(tipo){
        let valores=[];
        for (let index = 0; index < this.campos.length; index++) {
            let tipo=this.campos[index].type;
            if(tipo==='select' || tipo==='radio' || tipo==='checkbox' ){
                var name=this.campos[index].name;
                var val=document.getElementById(name).value;
                var ind=document.getElementById(name).selectedIndex;
                var texto =document.getElementById(val+'_'+ind).text;
            }else{
                var {name,val}=this.campos[index];
                var texto ="";
            }
            let objeto={name:name, value:val, texto:texto, para: this.para};
            valores.push(objeto);
            
        }

        if(tipo==="cambio"){
            this.$emit('cambio',valores);
        }else{
            $('#'+this.id).modal('hide');
            this.$emit('enviado',valores);
        }
        
    },
    cancelar(){
        this.$emit('cancelar');
    },
    cambioTextbox(nombreCampo,valor){
        this.$emit(nombreCampo,valor);
    }
},


    template: `<div :class="['ui','modal',tamanio]" :id="id">

                <div class="header">
                    {{titulo}}
                </div>
                <div class="content">
                    <h4>{{sub_titulo}}</h4>
                    <form action="" class="ui form" :id="id_form">
                        <div class="two fields">
                            <div v-for="campo in campos" class="field">
                                <label>{{campo.label}} </label>
                                <select class="ui dropdown" v-if="campo.type == 'select'" name="campo.name" :id="campo.name" @change="envio('cambio')">
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

                                <input v-else-if="campo.type == 'number'" :type="campo.type" :name="campo.name" :min="campo.min" :max="campo.max" :id="campo.name" v-model.number="campo.val" :step='campo.step' :disabled='campo.disabled' @change="cambioTextbox(campo.name,campo.val)" @keyup="cambioTextbox(campo.name,campo.val)" @keyup.enter="envio">

                                <input v-else :type="campo.type" :name="campo.name" :id="campo.name" v-model="campo.val" :disabled='campo.disabled'>
                                <div class="ui red pointing label" style="display: none;">
                                </div>
                            </div>
                        </div>
                    </form>        
                </div>
                <div class="actions">
                    <button class="ui black deny button" @click='cancelar'>
                        Cancelar
                    </button>
                    <button :class="['ui right green button',{disabled:deshabilitarenviar}]" id="btnEliminar" @click="envio" >
                        Registrar
                    </button>
                </div>
            </div>`
});