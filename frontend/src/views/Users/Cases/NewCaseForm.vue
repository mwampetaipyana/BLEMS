<template>
    <div @click.stop="" class="w-1/2 max-md:w-[96%] max-md:h-full min-w-fit h-3/4 bg-gray-50 rounded-lg mx-auto">
        <div class="w-3/4 h-full mx-auto py-8 p-4 flex flex-col">
            <div class="text-2xl text-gray-800 font-semibold tracking-tighter font-sans">
                Case Details
            </div> 
            <form @submit.prevent="addNewCase()" class="h-[90%] flex flex-col justify-between my-4 font-sans text-sm transition-all duration-500 ease-in overflow-y-auto" >
                <div class="w-full flex flex-col ">
                    <v-text-field
                    v-model="state.caseNo"
                    :error-messages="v$.caseNo.$errors.map(e => e.$message)"
                    label="Case number"
                    required
                    @blur="v$.caseNo.$touch"
                    @input="v$.caseNo.$touch"
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

                    <div class="w-full flex justify-between items-center">
                        <div class="w-1/2">
                            <v-checkbox v-model="state.addPersons"
                            label="Add Involved legal Participants"
                            ></v-checkbox>
                        </div>
                        <div class="w-1/2">
                            <v-text-field
                            density="compact"
                            class=" ml-auto"
                            :class="{'blur pointer-events-none':!state.addPersons}"
                            v-model="state.noOFPersons"
                            :error-messages="v$.noOFPersons.$errors.map(e => e.$message)"
                            label="Number of Participants"
                            required
                            @blur="v$.noOFPersons.$touch"
                            @input="v$.noOFPersons.$touch"
                            ></v-text-field>
                        </div>
                    </div>
                               
                    <div v-if="state.addPersons" class="w-full">
                        <div  v-for="n in Number(state.noOFPersons)" :key="n" class="w-full px-4 flex space-x-4 ">
                            <div  class="w-1/2">
                                <v-text-field
                                v-model="state.participants[n-1]"
                                :error-messages="v$.participants.$errors.map(e => e.$message)"
                                label="Participant Address"
                                required
                                @blur="v$.participants.$touch"
                                @input="v$.participants.$touch"
                                ></v-text-field>
                            </div>
                            <div v-if="addedParticipants[n-1] && addedParticipants[n-1] && !(addedParticipants[n-1][0]=='')" class="bg-[#30564b] bg-opacity-10 rounded-full flex px-3 h-[30px] items-center my-auto font-sans text-sm font-medium">
                                {{addedParticipants[n-1][0]}} <span class="text-gray-600">({{addedParticipants[n-1][1]}})</span> 
                            </div>
                            <div v-if="state.participants[n-1] && !addedParticipants[n-1]" class="bg-[#30564b] bg-opacity-10 rounded-full flex px-3 h-[30px] items-center my-auto font-sans text-sm font-medium">
                                 <span class="text-gray-600">INVALID ADDRESS</span> 
                            </div>
                            <div v-if="state.participants[n-1] && (addedParticipants[n-1]&&addedParticipants[n-1][0]=='')" class="bg-[#30564b] bg-opacity-10 rounded-full flex px-3 h-[30px] items-center my-auto font-sans text-sm font-medium">
                                 <span class="text-red-500">USER DOES NOT EXIST</span> 
                            </div>
                        </div>
                    </div>
                    
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
                        :loading="isSubmitted"
                        :disabled="!validated"
                        class="text-none"
                        color="main"
                        min-width="92"
                        rounded
                        type="submit"
                    >
                        <div class="font-sans">Submit</div>
                    </v-btn>
                </div>
            </form>
        </div>
    </div>
</template>

<script setup>
    import { ref,watch } from 'vue'
    import { useVuelidate } from '@vuelidate/core'
    import { integer, required } from '@vuelidate/validators'
    import { getSignerContract } from '@/utils/contractService';

    const isSubmitted = ref(false)

    const addedParticipants = ref([])
    const validated = ref(true)

    const getParticipantDetails = async(updatedIndex)=>{
        const {contract} = await getSignerContract()
        const userAddress = state.value.participants[updatedIndex]
        try{
            if(userAddress.length!=42){
                addedParticipants.value[updatedIndex] = null
                validated.value = false
                return;
            }
            addedParticipants.value[updatedIndex] = await contract.login(userAddress)
            if(addedParticipants.value[updatedIndex][0]==''){
                validated.value=false;
            }
        }
        catch(err){
            console.log(err);
            addedParticipants.value[updatedIndex]= null
            validated.value = false
        }
    }

    const initialState = {
        caseNo: '',
        description: '',
        noOFPersons:0,
        addPersons:false,
        participants:[]
    }

    const state = ref({
        ...initialState,
    })

    const items = [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
    ]

    const rules = {
        caseNo: { required },
        description: { required },
        noOFPersons:{integer, required},
        participants:{required}
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
    watch(()=>state.value.participants,()=>{
        state.value.participants.forEach((participant,index) => getParticipantDetails(index))
    }, { deep: true })

    const addNewCase = async()=>{
        isSubmitted.value = true;
        const {contract,signer} = await getSignerContract()
        const allParticipants = state.value.participants 
        await contract.addNewCase(state.value.caseNo, state.value.description, state.value.noOFPersons, allParticipants);
        close()
    }
   
</script>