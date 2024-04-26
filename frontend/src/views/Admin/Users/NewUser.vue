<template>
    <div @click.stop="" class="w-1/2 max-md:w-[96%] max-md:h-full min-w-fit h-3/4 bg-gray-50 rounded-lg mx-auto">
        <div class="w-3/4 h-full mx-auto py-8 p-4 flex flex-col">
            <div class="text-2xl text-gray-800 font-semibold tracking-tighter font-sans">
                User Details
            </div>
            <form class="h-[90%] flex flex-col justify-between my-4 font-sans text-sm transition-all duration-500 ease-in overflow-y-auto" >
                <div class="w-full flex flex-col ">
                    <v-text-field
                    v-model="state.name"
                    :error-messages="v$.name.$errors.map(e => e.$message)"
                    label="Name"
                    required
                    @blur="v$.name.$touch"
                    @input="v$.name.$touch"
                    ></v-text-field>

                    <v-text-field
                    v-model="state.address"
                    :error-messages="v$.address.$errors.map(e => e.$message)"
                    label="Address"
                    required
                    @blur="v$.address.$touch"
                    @input="v$.address.$touch"
                    ></v-text-field>

                    <v-select
                
                    v-model="state.position"
                    label="Position"
                    :items="['Judge', 'Law enforcement', 'Lawyer', 'Forensic']"
                    :error-messages="v$.position.$errors.map(e => e.$message)"
                    required
                    @blur="v$.position.$touch"
                    @input="v$.position.$touch"
                    ></v-select>

                </div>
                <div class="w-full flex justify-between">
                    <v-btn
                        class="text-none"
                        color="red"
                        min-width="92"
                        variant="outlined"
                        rounded
                        @click="close()"
                    >
                        Close
                    </v-btn>

                    <v-btn
                        class="text-none"
                        color="main"
                        min-width="92"
                        rounded
                        
                    >
                        <div class="font-sans">Submit</div>
                    </v-btn>
                </div>
            </form> 
        </div>    
    </div>
</template>

<script setup>
    import { ref } from 'vue'
    import { useVuelidate } from '@vuelidate/core'
    import { required} from '@vuelidate/validators'

    const search = ref('')

    const userDetails = {
        name: '',
        address:'',
        position:null
    }

    const state = ref({
        ...userDetails,
    })

   

    const rules = {
        name: { required },
        address: { required },
        position:{required}
    }

    const v$ = useVuelidate(rules, state)

    const clear = () => {
        v$.value.$reset()

        for (const [key, value] of Object.entries(initialState)) {
         state[key] = value
        }
    }

    const emit = defineEmits(["close"]);

    const close = ()=>{
        emit('close')
    }

</script>