<template>
    <div @click.stop="" class="w-1/2 min-w-fit h-3/4 bg-gray-50 rounded-lg">
        <div class="w-3/4 mx-auto py-8 p-4 flex flex-col">
            <div class="text-2xl text-gray-800 font-semibold tracking-tighter font-sans">
                Report Details
            </div>
            <form @click="addReport()" class="my-4 font-sans text-sm" >
                <v-text-field
                v-model="state.title"
                :error-messages="v$.title.$errors.map(e => e.$message)"
                label="Title"
                required
                @blur="v$.title.$touch"
                @input="v$.title.$touch"
                ></v-text-field>

                <v-text-field
                v-model="state.description"
                :counter="100"
                :error-messages="v$.description.$errors.map(e => e.$message)"
                label="Description"
                required
                @blur="v$.description.$touch"
                @input="v$.description.$touch"
                ></v-text-field>

                <v-text-field
                :disabled="case_no"
                v-model="state.caseNo"
                :error-messages="v$.caseNo.$errors.map(e => e.$message)"
                label="Case number"
                required
                @blur="v$.caseNo.$touch"
                @input="v$.caseNo.$touch"
                ></v-text-field>

                <v-file-input
                accept=".pdf,.docx,.doc"
                v-model="state.file"
                :error-messages="v$.file.$errors.map(e => e.$message)"
                label="Evidence File"
                required
                @blur="v$.file.$touch"
                @input="v$.file.$touch"
                ></v-file-input>

                <div class="w-full flex justify-between">
                    <v-btn
                        class="text-none"
                        color="red"
                        min-width="92"
                        variant="outlined"
                        rounded
                        @click="close()"
                    >
                        {{ case_no ? 'back' :'close' }}
                    </v-btn>

                    <v-btn
                        :disabled="isSubmitted"
                        type="submit"
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
    import { ref,onMounted } from 'vue'
    import { useVuelidate } from '@vuelidate/core'
    import { email, required } from '@vuelidate/validators'
    import {addFile} from '@/utils/PinataService.js'
    import { getSignerContract } from '@/utils/contractService';

    const {case_no} = defineProps(['case_no'])
    const isSubmitted = ref(false)

    const initialState = {
        title: '',
        caseNo: '',
        description: '',
        file:null
    }

    const state = ref({
        ...initialState,
    })

    onMounted(()=>{
        if(case_no){
            state.value.caseNo = case_no;
        }
    })

    const items = [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
    ]

    const rules = {
        title: { required },
        caseNo: { required },
        collector: { required },
        description: { required },
        location:{ required },
        file:{ required }
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

    const addReport = async()=> {
        isSubmitted.value = true;
        const {contract} =await getSignerContract();
        const cid = await addFile(state.value.title,state.value.file[0]);
        console.log(`this is the cid : ${cid}`);
        await contract.uploadReport(
            state.value.title,
            state.value.description,
            state.value.caseNo,
            cid
        )
        close();
    }

</script>

